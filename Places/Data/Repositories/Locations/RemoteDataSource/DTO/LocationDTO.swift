//
//  LocationDTO.swift
//  Places
//
//  Created by Andrei Marcu on 31.10.2024.
//

public struct LocationDTO: Codable {
    public let name: String?
    public let lat: Double?
    public let long: Double?
    
    public init(
        name: String?,
        lat: Double?,
        long: Double?
    ) {
        self.name = name
        self.lat = lat
        self.long = long
    }
}
