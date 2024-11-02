//
//  LocationRepositoryTests.swift
//  Places
//
//  Created by Andrei Marcu on 02.11.2024.
//

import Testing
import Foundation
@testable import Places

struct LocationRepositoryTests {
    @Test("Given a location repository, when fetching locations, then it should return a list of locations")
    func fetchLocations() async {
        let remoteDataSource = MockLocationRemoteDataSource()
        remoteDataSource.expectedResponse = .success(
            LocationsDTO(
                locations: [
                    LocationDTO.fixture()
                ]))
        let sut = LocationsRepository(remoteDataSource: remoteDataSource)
        await #expect(throws: Never.self , performing: {
            let locations = try await sut.getLocations()
            #expect(locations.locations.count == 1)
        })
    }
    
    @Test("Given a location repository, when fetching locations, then it should fail getting the locations")
    func fetchLocationsFailed() async {
        let remoteDataSource = MockLocationRemoteDataSource()
        remoteDataSource.expectedResponse = .failure(NSError(domain: "1", code: 123))
        let sut = LocationsRepository(remoteDataSource: remoteDataSource)
        await #expect(throws: NSError.self , performing: {
            _ = try await sut.getLocations()
        })
    }
}
