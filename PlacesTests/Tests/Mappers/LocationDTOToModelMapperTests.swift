//
//  LocationDTOToModelMapper.swift
//  PlacesTests
//
//  Created by Andrei Marcu on 02.11.2024.
//

import Testing
@testable import Places

struct LocationDTOToModelMapperTests {

    @Test("Given a location DTO, it should map it to a location model without error")
    func mapSucceeded() async throws {
        let dto = LocationDTO.fixture()
        let result = try LocationDTOTOModelMapper.map(dto)
        #expect(result.name == dto.name, "Name do not match")
        #expect(result.lat ==  dto.lat, "Latitude do not match")
        #expect(result.lon == dto.long, "Longitude do not match")
    }
    
    @Test("Given a location DTO with no name, it should map it to a location model without error")
    func givenDtoWithNoName_mapSucceeded() async throws {
        let dto = LocationDTO.fixture(name: nil)
        let result = try LocationDTOTOModelMapper.map(dto)
        #expect(result.name == dto.name, "Name do not match")
        #expect(result.name == nil, "Name should be nil")
        #expect(result.lat ==  dto.lat, "Latitude do not match")
        #expect(result.lon == dto.long, "Longitude do not match")
    }
    
    @Test("Given a location DTO no latitude, it should throw an error when mapping")
    func givenDtoWithNoLatitude_mapFails() async throws {
        let dto = LocationDTO.fixture(latitude: nil)
        do {
            _ = try LocationDTOTOModelMapper.map(dto)
        } catch {
            #expect(true, "Should not throw an error")
        }
    }
    
    @Test("Given a location DTO no longitude, it should throw an error when mapping")
    func givenDtoWithNoLongitude_mapFails() async throws {
        let dto = LocationDTO.fixture(longitude: nil)
        do {
            _ = try LocationDTOTOModelMapper.map(dto)
        } catch {
            #expect(true, "Should not throw an error")
        }
    }
    
    @Test("Given a location DTO no longitude and no latitude, it should throw an error when mapping")
    func givenDtoWithNoLongitudeAndLatitude_mapFails() async throws {
        let dto = LocationDTO.fixture(latitude: nil, longitude: nil)
        do {
            _ = try LocationDTOTOModelMapper.map(dto)
        } catch {
            #expect(true, "Should not throw an error")
        }
    }
}
