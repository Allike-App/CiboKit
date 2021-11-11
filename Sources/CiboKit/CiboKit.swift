import Foundation

public class Cibo {
    // MARK: - Authentications
    public var authentications: [Authentication] = []
    
    // MARK: - Services
    public var yelp: Api?
    public var `default`: Api! {
        return yelp
    }
    
    // MARK: - Initializations
    public init() { }
    
    public init(_ authentication: Authentication...) {
        self.authentications = authentication
        
        authentication.forEach { method in
            switch method {
            case .yelp:
                self.yelp = Api(authentication: method)
            }
        }
    }
}

// MARK: - SwiftUI Integration
#if canImport(SwiftUI)
import SwiftUI

@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
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
#endif
