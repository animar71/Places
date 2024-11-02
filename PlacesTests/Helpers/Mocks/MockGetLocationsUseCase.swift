//
//  MockGetLocationsUseCase.swift
//  Places
//
//  Created by Andrei Marcu on 02.11.2024.
//

import Foundation
@testable import Places

class MockGetLocationsUseCase: GetLocationsUseCaseProtocol {
    var expectedResponse: Result<Locations, Error> = .failure(NSError(domain: "1", code: 123))
    func start() async throws -> Locations {
        try expectedResponse.get()
    }
}
