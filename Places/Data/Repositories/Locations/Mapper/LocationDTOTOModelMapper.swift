//
//  LocationDTOTOModelMapper.swift
//  Places
//
//  Created by Andrei Marcu on 31.10.2024.
//

struct LocationDTOTOModelMapper {
    /// A static function that maps `LocationDTO` to `Location`
    ///
    /// - Parameters input: of type LocationDTO
    ///
    /// - Throws MapperError if the mapping fails
    ///
    /// - Returns an instance of `Location` with the data from the input
    public static func map(_ input: LocationDTO) throws -> Location {
        guard
            let lat = input.lat,
            let lon = input.long
        else {
            throw MapperError.mappingFailed("Latitude or longitude are missing")
        }
        
        return Location(
            name: input.name,
            lat: lat,
            lon: lon)
    }
}
