//
//  LocationsDTO.swift
//  Places
//
//  Created by Andrei Marcu on 02.11.2024.
//

@testable import Places

extension LocationsDTO {
    static func fixture(
        locations: [LocationDTO]
    ) -> Self {
        .init(locations: locations)
    }
}
