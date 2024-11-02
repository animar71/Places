//
//  LocationsViewModel.swift
//  Places
//
//  Created by Andrei Marcu on 01.11.2024.
//

import UIKit
import Combine
import Foundation

protocol LocationsViewModelProtocol: ObservableObject {
    /// An array of `Location` objects
    var locations: [Location] { get }
    /// A boolean used to display a progress of some sorts
    var isLoading: Bool { get }
    /// A boolean that tells the view when to show an alert
    var showingAlert: Bool { get set }
    /// The message from the alert
    var alertMessage: String { get }
    
    /// Called when a location from the list is tapped
    ///
    /// - Parameter id: the `id` of the tapped location
    func didTapLocation(id: String)
}

class LocationsViewModel: LocationsViewModelProtocol {
    @Published var locations: [Location] = []
    @Published var isLoading: Bool = false
    @Published var showingAlert = false
    private(set) var alertMessage = ""
    
    private let getLocationsUseCase: GetLocationsUseCaseProtocol
    
    init(getLocationsUseCase: GetLocationsUseCaseProtocol) {
        self.getLocationsUseCase = getLocationsUseCase
        
        loadLocations()
    }
    
    func didTapLocation(id: String) {
        guard let location = locations.first(where: { $0.id == id }) else { return }
        
        var path = "wikipedia://places/location?lat=\(location.lat)&lon=\(location.lon)"
        if let locationName = location.name {
            path.append("&name=\(locationName)")
        }
        
        let url = URL(string: path)!
        UIApplication.shared.open(url)
    }
}
 

// MARK: - Private API
private extension LocationsViewModel {
    /// Retrieves the locations
    func loadLocations() {
        isLoading = true
        Task {
            do {
                let locations = try await getLocationsUseCase.start()
                await MainActor.run {
                    self.locations = locations.locations
                    isLoading = false
                }
            } catch {
                await MainActor.run {
                    isLoading = false
                    alertMessage = "An error occurred while retrieving locations: \(error.localizedDescription)"
                    showingAlert = true
                }
            }
        }
    }
}

// MARK: - Preview Instance
class MockedLocationsViewModel: LocationsViewModelProtocol, ObservableObject {
    @Published var locations: [Location] = []
    @Published var isLoading: Bool = true
    @Published var showingAlert = false
    private(set) var alertMessage = ""
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
            isLoading = false
            locations = [
                .init(
                    name: "Amsterdam",
                    lat: 1.123456,
                    lon: 2.345678),
                .init(
                    name: "Rotterdam",
                    lat: 3.456789,
                    lon: 4.567890),
                .init(
                    name: nil,
                    lat: 5.678901,
                    lon: 6.789012)
            ]
        }
    }
    
    func didTapLocation(id: String) {}
}
