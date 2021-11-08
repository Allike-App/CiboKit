import Foundation
#if canImport(SwiftUI)
import SwiftUI
#endif

public class Cibo {
    var authentication: Authentication!
    
    public init() { }
    
    public init(_ authentication: Authentication) {
        self.authentication = authentication
    }
    
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    public func search(_ type: SearchType = .food,
                       coordinates: Coordinates,
                       radius: Int = 8000,
                       limit: Int = 20) async throws -> [Location] {
        
        let searchRequest = try createSearchRequest(type: type,
                                                    coordinates: coordinates,
                                                    radius: radius,
                                                    limit: limit)
        
        switch authentication {
        case .yelp:
            let data = try await searchRequest.session.data(for: searchRequest.request).0
            
            let yelpItems = try JSONDecoder().decode(YelpSearchResponse.self, from: data)
            
            return yelpItems.businesses.map(Location.init)
        case .none:
            throw CocoaError(.coderValueNotFound)
        }
    }
    
    public func search(_ type: SearchType = .food,
                       coordinates: Coordinates,
                       radius: Int = 8000,
                       limit: Int = 20,
                       completion: @escaping (Result<[Location], Error>) -> Void) {
        
        do {
            let searchRequest = try createSearchRequest(type: type,
                                                        coordinates: coordinates,
                                                        radius: radius,
                                                        limit: limit)
            
            switch authentication {
            case .yelp:
                searchRequest.session.dataTask(with: searchRequest.request) { data, response, error in
                    do {
                        guard let data = data else { throw URLError(.badServerResponse) }
                        let yelpItems = try JSONDecoder().decode(YelpSearchResponse.self, from: data)
                        
                        completion(.success(yelpItems.businesses.map(Location.init)))
                    } catch {
                        completion(.failure(error))
                    }
                }.resume()
            case .none:
                throw URLError(.userAuthenticationRequired)
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    private func createSearchRequest(type: SearchType = .food,
                                     coordinates: Coordinates,
                                     radius: Int,
                                     limit: Int) throws -> (session: URLSession, request: URLRequest) {
        switch authentication {
        case .yelp(let yelp):
            guard var urlComponents = URLComponents(string: "https://api.yelp.com/v3/businesses/search") else { throw URLError(.badURL) }
            
            urlComponents.queryItems = [
                URLQueryItem(name: "term", value: type.rawValue),
                URLQueryItem(name: "latitude", value: "\(coordinates.latitude)"),
                URLQueryItem(name: "longitude", value: "\(coordinates.longitude)"),
                URLQueryItem(name: "radius", value: "\(radius)"),
                URLQueryItem(name: "limit", value: "\(limit)")
            ]
            
            guard let url = urlComponents.url else { throw URLError(.badURL) }
            let urlRequest = URLRequest(url: url)
            
            let sessionConfiguration = URLSessionConfiguration.default
            sessionConfiguration.httpAdditionalHeaders = [
                "Authorization": "Bearer \(yelp.apiKey)"
            ]
            let session = URLSession(configuration: sessionConfiguration)
            
            return (session, urlRequest)
        case .none:
            throw CocoaError(.fileReadUnknown)
        }
    }
}

private struct CiboKey: EnvironmentKey {
    static let defaultValue = Cibo.init()
}

@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
extension EnvironmentValues {
    public var cibo: Cibo {
        get { self[CiboKey.self] }
        set { self[CiboKey.self] = newValue }
    }
}
