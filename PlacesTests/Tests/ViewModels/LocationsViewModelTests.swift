//
//  LocationsViewModelTests.swift
//  Places
//
//  Created by Andrei Marcu on 02.11.2024.
//

import Testing
import Foundation
@testable import Places

struct LocationsViewModelTests {
    @Test("Given the location are retrieved, then the view model should update the locations")
    func locationsRetrieved() async {
        let mockUseCase = MockGetLocationsUseCase()
        mockUseCase.expectedResponse = .success(.init(
            locations: [
                .fixture(),
                .fixture()
            ]))
        let sut = LocationsViewModel(getLocationsUseCase: mockUseCase)
        
        try? await Task.sleep(nanoseconds: 500_000_000)

        #expect(sut.showingAlert == false)
        #expect(sut.locations.count == 2)
    }
    
    @Test("Given the location are retrieved, when there is an error getting it, then the view model should show an alert")
    func locationsNotRetrieved() async {
        let mockUseCase = MockGetLocationsUseCase()
        mockUseCase.expectedResponse = .failure(NSError(domain: "1", code: 123))
        let sut = LocationsViewModel(getLocationsUseCase: mockUseCase)
        
        try? await Task.sleep(nanoseconds: 500_000_000)

        #expect(sut.showingAlert == true)
        #expect(sut.locations.count == 0)
    }
}
