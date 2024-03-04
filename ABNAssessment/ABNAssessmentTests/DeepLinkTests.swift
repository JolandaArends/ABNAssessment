//
//  DeepLinkTests.swift
//  ABNAssessmentTests
//
//  Created by Jolanda Arends on 04/03/2024.
//

import XCTest
@testable import ABNAssessment
import CoreLocation

final class DeepLinkTests: XCTestCase {
    func test_createPlacesDeepLinkWithCoordinates_withLocation_resultsInURL() throws {
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 52.3547498,
                                                                      longitude: 4.8339215)
        
        let result = DeepLink.createPlacesDeepLinkWithCoordinates(for: location)
       
        let urlString = try XCTUnwrap(result?.absoluteURL.absoluteString)
        XCTAssertEqual(urlString, "wikipedia://places?WMFCoordinates=52.3547498,4.8339215")
    }
}
