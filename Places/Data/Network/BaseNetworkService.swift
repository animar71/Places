//
//  BaseNetworkService.swift
//  Places
//
//  Created by Andrei Marcu on 31.10.2024.
//

import Foundation

/// A custom error enum that can be thrown by the networking layer
enum NetworkError: Error, Equatable {
    case invalidURL
    case invalidPath
}

// MARK: - HTTPMethod
/// HTTP Methods that can be used in making calls to the BE
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

/// Protocol defining the functionality of BaseNetworkService
protocol BaseNetworkServiceProtocol {
    /// This should be called to get a non nullable Decodable object
    ///
    /// - Parameters path: the path as a String against the GET is performed
    /// - Parameters parameters: a dictionary that will used to create query parameters for the GET call
    ///
    ///  - Returns the response of type T: Decodable
    func get<T: Decodable>(
        path: String,
        parameters: [String: String]
    ) async throws -> T
    
    /// This should be called to get a  nullable Decodable object
    ///
    /// - Parameters path: the URL path as a String against the GET is performed
    /// - Parameters parameters: a dictionary that will used to create query parameters for the GET call
    ///
    /// - Throws error generated by the network request or by the JSONDecoder
    ///
    ///  - Returns the optional response of type T: Decodable
    func getOptional<T: Decodable>(
        path: String,
        parameters: [String: String]
    ) async throws -> T?
}

struct BaseNetworkService: BaseNetworkServiceProtocol {
    func get<T: Decodable>(
        path: String,
        parameters: [String: String] = [:]
    ) async throws -> T {
        let data = try await request(uri: path, parameters: parameters, httpMethod: .get)
        let result = try JSONDecoder().decode(T.self, from: data)
        return result
    }
    
    func getOptional<T: Decodable>(
        path: String,
        parameters: [String: String] = [:]
    ) async throws -> T? {
        let data = try await request(uri: path, parameters: parameters, httpMethod: .get)
        guard data.isEmpty else { return nil }
        let result = try JSONDecoder().decode(T.self, from: data)
        return result
    }
}

// MARK: - Private API
private extension BaseNetworkService {
    /// A general method to create HTTP network calls
    ///
    /// - Parameter uri: the url path
    /// - Parameter parameters: query parameters. By default is an empty dictionary
    /// - Parameter headers: custom headers to be injected. By default empty dictionary
    /// - Parameter body: an optional parameter for body request. By default nil
    ///
    /// - Throws errors generated by URLSession Data request
    ///
    /// - Returns the resulting data received
    func request(
        uri: String,
        parameters: [String: String] = [:],
        httpMethod: HTTPMethod,
        headers: [String: String] = [:],
        body: Data? = nil
    ) async throws -> Data {
        let url = try getUrlWith(path: uri, parameters: parameters)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue

        headers.forEach { (key, value) in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }

        urlRequest.httpBody = body

        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        return data
    }
}

// MARK: - Helpers
private extension BaseNetworkService {
    /// Returns a URL based on the path and parameters given
    ///
    /// - Parameter path: the path based on witch the URL is build
    /// - Parameter parameters: query parameters to be added to the URL
    ///
    /// - Throws `NetworkError.invalidPath` if URLComponents cannot be extracted
    /// - Throws `NetworkError.invalidURL` if URL cannot be created
    ///
    /// - Returns: URL based on the path given and with query parameters constructed from `parameters` parameter
    func getUrlWith(path: String, parameters: [String: String]) throws -> URL {
        guard var urlComponents = URLComponents(string: path) else {
            throw NetworkError.invalidPath
        }

        if !parameters.isEmpty {
            urlComponents.queryItems = parameters.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }

        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }

        return url
    }
}