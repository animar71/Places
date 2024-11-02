//
//  LocationsDataSource.swift
//  Places
//
//  Created by Andrei Marcu on 31.10.2024.
//

protocol LocationsRemoteDataSourceProtocol {
    /// Makes a get call to `https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json` in order to get
    ///  the list of locations.
    ///
    /// - Throws network and decoder errors
    ///
    /// - Returns WeatherDTO object
    func getLocations() async throws -> LocationsDTO
}

class LocationsRemoteDataSource: LocationsRemoteDataSourceProtocol {
    let network: BaseNetworkServiceProtocol
    
    init(network: BaseNetworkServiceProtocol = BaseNetworkService()) {
        self.network = network
    }
    
    func getLocations() async throws -> LocationsDTO {
        try await network.get(path: "https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json", parameters: [:])
    }
}
