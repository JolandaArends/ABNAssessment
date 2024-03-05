//
//  SimpleAPI.swift
//  ABNAssessment
//
//  Created by Jolanda Arends on 04/03/2024.
//

import Foundation

protocol SimpleDataFetcher {
    func fetchLocations() async throws -> LocationsList
}

/// SimpleAPI
/// Since we only have 1 endpoint to 'request'
struct SimpleAPI: SimpleDataFetcher {

    /// Fetch the locations provided by the ABN Amro for the assessment
    /// - Returns: an object with a list of locations
    func fetchLocations() async throws -> LocationsList {
        // Setup and/or check request. No need for it here, since we're only using an url to fetch data from.
        
        // Perform request
        let (data, response) = try await URLSession.shared.data(from: APIEndpoint.locations)
        
        // F.e. Do some checks on the response
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw APIError.serverRespondedWithError
        }
        
        // Decode data from response
        guard let locationsList = try? JSONDecoder().decode(LocationsList.self, from: data) else {
            throw APIError.couldNotParseResult
        }
        
        return locationsList
    }
}

