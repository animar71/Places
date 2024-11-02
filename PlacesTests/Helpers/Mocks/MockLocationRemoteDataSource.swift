//
//  MockLocationRemoteDataSource.swift
//  Places
//
//  Created by Andrei Marcu on 02.11.2024.
//

import Foundation
@testable import Places

class MockLocationRemoteDataSource: LocationsRemoteDataSourceProtocol {
    var expectedResponse: Result<LocationsDTO, Error> = .failure(NSError(domain: "1", code: 123))
    func getLocations() async throws -> LocationsDTO {
        try expectedResponse.get()
    }
}
