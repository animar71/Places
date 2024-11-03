# Wikipedia Places Demo

## Project Overview
This project allows users to view a list of pre-defined locations, select one, and open it directly in the Wikipedia app’s Places view. The Wikipedia app (https://github.com/animar71/CustomWikipedia) must be modified to add support for deep linking for specific locations.

## Features
* **Deep Linking to Wikipedia ‘Places’ Tab**: Opens Wikipedia’s ‘Places’ view at specified coordinates through custom deep links.
* **Location List and Custom Coordinates**: Provides a list of locations and an option for users to enter custom coordinates to view on Wikipedia.
* **SwiftUI Interface**: Uses SwiftUI to build a clean and responsive UI.
* **Accessibility Enhancements**: Optimized for accessibility.
* **Swift Concurrency**: Utilizes async/await for efficient data handling.

## Dependencies
The modified wikipedia app needs to be installed on the device in order to open the custom location in the Places view.

## Usage
1. **Selecting a Location**:
   * Run Places on an iOS device or simulator.
   * Choose a location from the list, which will open the Wikipedia app directly in the ‘Places’ tab at that location.
2. **Entering Custom Coordinates**:
   * Enter coordinates manually in the input field and open the specified location in the Wikipedia app using the custom deep link functionality.
4. **Deep Link Testing**:
   *	Each location in the app triggers a URL scheme-based deep link to Wikipedia, allowing you to view specific locations directly.
   *	The deeplink is in the format "wikipedia://places/location?lat=\(latitudeDouble)&lon=\(longitudeDouble)"
  
## Architecture

The app follows the MVVM (Model-View-ViewModel) architecture, CLEAN and SOLID principles:
* **ViewModels**: Manage data fetching, user input, and error handling, keeping views lightweight and focused on UI.
* **Data Layer**: Asynchronously fetches and decodes JSON data using Swift Concurrency.
* **Deep Linking Logic**: Encodes the selected location’s coordinates into a URL scheme compatible with the modified Wikipedia app.

## Concurrency

Swift Concurrency (async/await) is implemented for:
* **Data Fetching**: Asynchronous loading of location data from the provided JSON URL without blocking the UI.
* **UI Responsiveness**: The main thread remains free for user interactions while background tasks load data efficiently.

## Testing
* **Unit Testing**: Tests are implemented for ViewModel logic and data handling, use cases, mappers, repository and remote data sources.
* **Combine Tests**: Validate asynchronous data loading and the behavior of @Published properties.
