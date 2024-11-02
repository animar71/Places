//
//  LocationsDTOTOModelMapperTests.swift
//  Places
//
//  Created by Andrei Marcu on 02.11.2024.
//

import Testing
@testable import Places

struct LocationsDTOToModelMapperTests {
    @Test("Given a locations DTO, it should map it to a location model without error")
    func mapSucceeded() async throws {
        let locations = [
            LocationDTO.fixture(
                latitude: 1.1,
                longitude: 2.2
            ),
            LocationDTO.fixture(
                latitude: 1.1,
                longitude: 2.2
            )
        ]
        let dto = LocationsDTO.fixture(locations: locations)
        let result = try LocationsDTOTOModelMapper.map(dto)
        #expect(result.locations.count == 2)
    }
    
    @Test("Given a locations DTO, when the one of the LocationDTO is missing longitude, the mapping should fail")
    func mapFailed() async throws {
        let locations = [
            LocationDTO.fixture(
                latitude: nil,
                longitude: 2.2
            ),
            LocationDTO.fixture(
                latitude: 1.1,
                longitude: 2.2
            )
        ]
        
        let dto = LocationsDTO.fixture(locations: locations)
        
        #expect(throws: MapperError.self, performing: {
            _ = try LocationsDTOTOModelMapper.map(dto)
        })
    }
}
