//
//  MockLocationsRepository.swift
//  Places
//
//  Created by Andrei Marcu on 02.11.2024.
//

import Foundation
@testable import Places

class MockLocationRepository: LocationsRepositoryProtocol {
    var expectedResponse: Result<Locations, Error> = .failure(NSError(domain: "1", code: 123))
    func getLocations() async throws -> Locations {
        try expectedResponse.get()
    }
}
