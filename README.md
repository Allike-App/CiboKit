# CiboKit

A simple and lightweight resturant finder using the Yelp API

## What is CiboKit?

CiboKit is used in our app, *Allike*, to find nearby restaurants using Swift’s concurrency. It is built modularly to support alternative APIs and makes searching these APIs for resturants super simple and easy. In just a few lines of code, you can search for dozens of nearby restaurants asynchronously *(non-asynchronous functions are also available)*.

*Cibo* comes from the Italian word for food.

## Usage

Initialize the framework using the Yelp API. You can create an app and get credentials for Yelp [here](https://fusion.yelp.com).

```swift
let cibo = Cibo(.yelp(.init(clientID: "INSERT_CLIENT_ID",
                            apiKey: "INSERT_API_KEY")))
```

#### Then you can use this object to search.

##### Asynchronously

```swift
try await cibo.search(.food,
                      coordinates: Coordinates(latitude: 0,
                                               longitude: 0),
                      radius: 40000,
                      limit: 50)
// or to use default values based on the API
try await cibo.search(coordinates: Coordinates(latitude: 0,
                                               longitude: 0))
```

##### Synchronously

```swift
cibo.search(coordinates: Coordinates(latitude: 0,
                                     longitude: 0)) { result in
    switch result {
    case .success(let locations):
        // Got locations
    case .failure(let error):
        // Failed somewhere
    }
}
```

#### Use in SwiftUI

You can add the Cibo object as an environment variable to SwiftUI views.

```swift
@Environment(\.cibo) var cibo

view.environment(\.cibo, cibo)
```

## Installation

Add it as a Swift Package

```
https://github.com/Allike-App/CiboKit.git
```

## Acknowledgements

* [Yelp API](https://fusion.yelp.com)
