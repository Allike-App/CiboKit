# CiboKit

A simple and lightweight resturant finder using the Yelp API

## What is CiboKit?

CiboKit is used in our app, *Allike*, to find nearby restaurants using Swift’s concurrency. It is built modularly to support alternative APIs and makes searching these APIs for resturants super simple and easy. In just a few lines of code, you can search for dozens of nearby restaurants asynchronously *(non-asynchronous functions are also available)*.

*Cibo* comes from the Italian word for food.

## Usage

Initialize the framework using the Yelp API. You can create an app and get credentials for Yelp [here](https://fusion.yelp.com).

```swift
let cibo = Cibo(.yelp(clientID: "INSERT_CLIENT_ID",
                            apiKey: "INSERT_API_KEY"))
```
This is a variadic function, so you can supply multiple credentials at once.

***WARNING**: Do not supply multiple credentials for the same service*

#### You can use multiple services with the same Cibo instance. Just go through the specific service you want, for example, with Yelp you would use `cibo.yelp?.search`.
##### Available services
* Yelp – `yelp?`
* Default – `default!` *(if you aren't sure the Cibo instance has any credentials, be sure to unwrap this)*

#### Then you can use this object to search.

##### Asynchronously

```swift
try await cibo.default.search(.food,
                      coordinates: Coordinates(latitude: 0,
                                               longitude: 0),
                      radius: 40000,
                      limit: 50)
// or to use default values based on the API
try await cibo.default.search(coordinates: Coordinates(latitude: 0,
                                               longitude: 0))
```

##### Synchronously

```swift
cibo.default.search(coordinates: Coordinates(latitude: 0,
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
