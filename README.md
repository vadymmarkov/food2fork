# Food2Fork

The `Food2Fork` iOS app implemented as a part of
[oboarding process](https://github.com/finn-no/ios-handbook/blob/master/ONBOARDING_PROJECT.md).
at [FINN.no](https://github.com/finn-no).

## Features

### Explore

- Discover new recipes from different publishers sorted by rating
- Use pull-to-refresh to reload content
- Scroll to the bottom for pagination
- Open recipe detail by selecting any recipe in the collection view

### Search
- Search recipes by ingredients or name (3 letters and more)
- Open search bar by focusing in it or by tapping the `Search` button
- Scroll to the bottom for pagination
- Open recipe detail by selecting any recipe in the table view

### Favorites

- Save your favorites for later by tapping ❤️ button on the recipe detail screen
- See your favorite recipes offline (and online 😃) on the `Favorites` tab
- Open recipe detail by selecting any recipe in the table view

## Architecture

- The app is built using the Model-View-Controller design pattern
- Navigation logic is moved out of view controllers into dedicated `Navigator` objects
- Dependency injection is implemented using factory protocols and `DependencyContainer` class,
which contains all of the app's core utility objects that are directly injected
as dependencies
- The core logic of view controllers is extracted into matching logic controllers,
where each action returns a new state to render as part of a completion handler.

## Networking

- [Malibu](https://github.com/vadymmarkov/Malibu) library is used as an
abstraction layer for networking
- Images are loaded by `ImageLoader` utility class, which plays the role of
a wrapper around `URLSession` and `URLCache`

## Persistency

- `CoreData` is used as a persistency layer
- `NSManagedObjectContext` is hidden behind `ReadableStore` and `WritableStore`
protocols for better separation of concerns
- `URLCache` provides a composite in-memory and on-disk cache for images loaded
from network

## API

- Food2Fork Recipe API documentation: https://www.food2fork.com/about/api
- Note that the Free plan allows only 50 API calls per day
- If you want to mock requests just open `DependencyContainer.swift` and
create `Networking` instance with the same `MockProvider` as for UI and Unit tests.
