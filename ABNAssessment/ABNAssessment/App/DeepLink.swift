//
//  DeepLink.swift
//  ABNAssessment
//
//  Created by Jolanda Arends on 04/03/2024.
//

import Foundation
import CoreLocation

// Create deeplinks
struct DeepLink {
    private struct Constants {
        static let placesURL = "wikipedia://places"
    }
    
    /// Create a deeplink for the places tab with coordinates
    ///
    /// - Parameter location: the location (coordinates) to attach to the query
    /// - Returns: a deeplink for the wikipedia app
    static func createPlacesDeepLinkWithCoordinates(for location: CLLocationCoordinate2D) -> URL? {
        let coordinatesQueryString = "?WMFCoordinates="
        let coordinatesParamString = "\(location.latitude),\(location.longitude)"
        return URL(string: Constants.placesURL + coordinatesQueryString + coordinatesParamString)
    }
}

