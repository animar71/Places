//
//  LocationsRepository.swift
//  Places
//
//  Created by Andrei Marcu on 31.10.2024.
//

protocol LocationsRepositoryProtocol {
    /// Uses an instance of `LocationsRemoteDataSourceProtocol` to get the Locations  information and returns a `Locations` object.
    ///
    /// - Throws network, decoder errors or mapping errors
    ///
    /// - Returns `Locations` object
    func getLocations() async throws -> Locations
}

class LocationsRepository: LocationsRepositoryProtocol {
    private let remoteDataSource: LocationsRemoteDataSourceProtocol
    
    init (remoteDataSource: LocationsRemoteDataSourceProtocol = LocationsRemoteDataSource()) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getLocations() async throws -> Locations {
        let dto = try await remoteDataSource.getLocations()
        return try LocationsDTOTOModelMapper.map(dto)
    }
}
