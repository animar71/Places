//
//  LocationDTO.swift
//  Places
//
//  Created by Andrei Marcu on 02.11.2024.
//

import Places

extension LocationDTO {
    static func fixture(
        name: String? = "Test Location",
        latitude: Double? = 1.0,
        longitude: Double? = 2.0
    ) -> Self {
        .init(
            name: name,
            lat: latitude,
            long: longitude)
    }
}
