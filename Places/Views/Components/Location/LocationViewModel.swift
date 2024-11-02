//
//  LocationViewModel.swift
//  Places
//
//  Created by Andrei Marcu on 01.11.2024.
//

import Combine
import Foundation

protocol LocationViewModelProtocol: ObservableObject {
    /// Name of the location
    var name: String { get }
    /// Latitude of the location
    var latitude: String { get }
    /// Longitude of the location
    var longitude: String { get }
    
    /// Called when the view was tapped
    func didTapView()
}

class LocationViewModel: LocationViewModelProtocol {
    @Published var name: String
    @Published var latitude: String
    @Published var longitude: String
    var onViewTapped: ((_ id: String) -> Void)?
    
    private let location: Location
    
    init(location: Location, onViewTapped: ((_ id: String) -> Void)?) {
        self.location = location
        self.onViewTapped = onViewTapped
        
        // TODO: The strings should come from Localizable.strings file
        self.name = location.name ?? "Unknown location"
        self.latitude = String(format: "Latitude: %f", location.lat)
        self.longitude = String(format: "Longitude: %f", location.lon)
    }
    
    func didTapView() {
        onViewTapped?(location.id)
    }
}
