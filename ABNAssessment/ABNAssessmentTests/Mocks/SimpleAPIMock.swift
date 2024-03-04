//
//  SimpleAPIMock.swift
//  ABNAssessmentTests
//
//  Created by Jolanda Arends on 04/03/2024.
//

import Foundation
@testable import ABNAssessment

final class SimpleAPIMock: SimpleDataFetcher {
    var error: APIError?
    var locations: LocationsList = LocationsList(locations: [])

    func fetchLocations() async throws -> ABNAssessment.LocationsList {
        if let error = error {
            throw error
        }
        
        return locations
    }
}

