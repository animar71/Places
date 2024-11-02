//
//  CustomLocationViewModel.swift
//  Places
//
//  Created by Andrei Marcu on 01.11.2024.
//

import UIKit
import Combine
import Foundation

protocol CustomLocationViewModelProtocol: ObservableObject {
    /// The location name from the user will be saved here
    var locationName: String { get set }
    /// The latitude from the user will be saved here
    var latitude: String { get set }
    /// The longitude from the user will be saved here
    var longitude: String { get set }
    /// The label for the location name
    var locationNameLabel: String { get }
    /// The placeholder displayed in the location name TextField
    var locationNamePlaceholder: String { get }
    /// The label for the latitude
    var latitudeLabel: String { get }
    /// The placeholder displayed in the latitude TextField
    var latitudePlaceholder: String { get }
    /// The label for the longitude
    var longitudeLabel: String { get }
    /// The placeholder displayed in the longitude TextField
    var longitudePlaceholder: String { get }
    /// A boolean that tells the view when to show an alert
    var showingAlert: Bool { get set }
    /// The message from the alert
    var alertMessage: String { get }
    
    /// Called when the user finished with the form
    ///
    /// - Returns true if the form is valid, false otherwise
    func tappedContinue() -> Bool
}

class CustomLocationViewModel: CustomLocationViewModelProtocol {
    @Published var locationName: String = ""
    @Published var latitude: String = ""
    @Published var longitude: String = ""
    @Published var showingAlert = false
    private(set) var alertMessage = ""
    
    // TODO: The strings should be retrieved from Localizable.strings
    var locationNameLabel = "Location name"
    var locationNamePlaceholder = "Paris"
    var latitudeLabel = "Latitude"
    var latitudePlaceholder = "48.856614"
    var longitudeLabel = "Longitude"
    var longitudePlaceholder = "2.352222"
    
    func tappedContinue() -> Bool {
        guard let latitudeDouble = Double(latitude),
                let longitudeDouble = Double(longitude) else {
            alertMessage = "The latitude or longitude is incorrect"
            showingAlert = true
            return false
        }
        
        var path = "wikipedia://places/location?lat=\(latitudeDouble)&lon=\(longitudeDouble)"
        if !locationName.isEmpty {
            path.append("&name=\(locationName)")
        }
        
        let url = URL(string: path)!
        UIApplication.shared.open(url)
        
        return true
    }
}
