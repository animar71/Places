//
//  GetLocationsUseCaseTests.swift
//  Places
//
//  Created by Andrei Marcu on 02.11.2024.
//

import Testing
import Foundation
@testable import Places

struct GetLocationsUseCaseTests {
    @Test("Given a valid request, when the use case is executed, then the response is returned")
    func getLocations() async {
        let mockRepository = MockLocationRepository()
        mockRepository.expectedResponse = .success(.init(
            locations: [
                .fixture()
            ]))
        let sut = GetLocationsUseCase(repository: mockRepository)
        await #expect(throws: Never.self , performing: {
            let locations = try await sut.start()
            #expect(locations.locations.count == 1)
        })
    }
    
    @Test("Given an invalid request, when the use case is executed, then the use case fails")
    func getLocationsFails() async {
        let mockRepository = MockLocationRepository()
        mockRepository.expectedResponse = .failure(NSError(domain: "1", code: 123))
        let sut = GetLocationsUseCase(repository: mockRepository)
        await #expect(throws: NSError.self , performing: {
            _ = try await sut.start()
        })
    }
}
