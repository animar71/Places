//
//  GetLocationsUseCase.swift
//  Places
//
//  Created by Andrei Marcu on 01.11.2024.
//

import Foundation

protocol GetLocationsUseCaseProtocol {
    /// Call this method to get a `Locations` response from the `LocationsRepositoryProtocol`
    ///
    /// - Throws networking and mapping errors
    ///
    /// - Returns the resulting `Locations` response
    func start() async throws -> Locations
}

/// A use case used for getting the locations. This use case uses an instance of `LocationsRepositoryProtocol` for
/// getting the Locations object.
struct GetLocationsUseCase: GetLocationsUseCaseProtocol {
    private let repository: LocationsRepositoryProtocol

    init(repository: LocationsRepositoryProtocol = LocationsRepository()) {
            self.repository = repository
        }

    func start() async throws -> Locations {
        try await repository.getLocations()
    }
}
