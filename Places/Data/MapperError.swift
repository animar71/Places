//
//  MapperError.swift
//  Places
//
//  Created by Andrei Marcu on 31.10.2024.
//

import Foundation

enum MapperError: Error {
    case decodingFailed
    case mappingFailed(String) // Additional info if needed
}

// TODO: - The error descriptions can be localised using LocalizableStrings files. For this assignment I won't add this complexity
extension MapperError: LocalizedError {
    /// Returns the description for the specific errors
    var errorDescription: String? {
        switch self {
        case .decodingFailed:
            return "Decoding of data failed."
        case .mappingFailed(let reason):
            return "Mapping failed: \(reason)"
        }
    }
}
