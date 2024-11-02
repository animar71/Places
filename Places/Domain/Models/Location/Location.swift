//
//  Location.swift
//  Places
//
//  Created by Andrei Marcu on 31.10.2024.
//

import Foundation

public struct Location: Identifiable {
    public var id = UUID().uuidString
    public let name: String?
    public let lat: Double
    public let lon: Double
    
    public init(
        name: String?,
        lat: Double,
        lon: Double
    ) {
        self.name = name
        self.lat = lat
        self.lon = lon
    }
}
