//
//  LocationsDTOToModelMapper.swift
//  Places
//
//  Created by Andrei Marcu on 31.10.2024.
//

struct LocationsDTOTOModelMapper {
    /// A static function that maps `LocationsDTO` to `Locations`
    ///
    /// - Parameters input: of type LocationsDTO
    ///
    /// - Throws MapperError if the mapping fails
    ///
    /// - Returns an instance of `Locations` with the data from the input
    static func map(_ input: LocationsDTO) throws -> Locations {
        let locations = try input.locations.map { try LocationDTOTOModelMapper.map($0) }
        
        return Locations(locations: locations)
    }
}
