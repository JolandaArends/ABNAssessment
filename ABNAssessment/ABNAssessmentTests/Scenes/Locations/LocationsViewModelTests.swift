//
//  LocationsViewModelTests.swift
//  ABNAssessmentTests
//
//  Created by Jolanda Arends on 04/03/2024.
//

import XCTest
@testable import ABNAssessment

final class LocationsViewModelTests: XCTestCase {
    
    // MARK: Init
    func test_init_abnLocationsState_isLoading() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.abnLocationsState, .loading)
    }
    
    func test_init_locations_isEmpty() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.locations, [])
    }
    
    // MARK: fetchLocations
    func test_fetchLocations_whenResponseContainsEmptyList_thenLocationsIsEmpty() async {
        let sut = makeSUT(locations: [])
        
        await sut.fetchLocations()
        XCTAssertEqual(sut.locations, [])
    }
    
    func test_fetchLocations_whenResponseContainsEmptyList_thenAbnLocationsStateIsEmpty() async {
        let sut = makeSUT(locations: [])
        
        await sut.fetchLocations()
        XCTAssertEqual(sut.locations, [])
    }
    
    func test_fetchLocations_whenResponseContainsLocations_thenLocationsIsFilled() async {
        let locations = testLocations
        let sut = makeSUT(locations: locations)
        
        await sut.fetchLocations()
        XCTAssertEqual(sut.locations, locations)
    }
    
    func test_fetchLocations_whenResponseContainsLocations_thenAbnLocationsStateIsResults() async {
        let sut = makeSUT(locations: testLocations)
        
        await sut.fetchLocations()
        XCTAssertEqual(sut.abnLocationsState, .results)
    }
    
    func test_fetchLocations_whenResponseContainsError_thenLocationsIsEmpty() async {
        let error = APIError.serverRespondedWithError
        let sut = makeSUT(error: error)
        
        await sut.fetchLocations()
        
        XCTAssertEqual(sut.locations, [])
    }
    
    func test_fetchLocations_whenResponseContainsError_thenAbnLocationsStateIsError() async {
        let error = APIError.serverRespondedWithError
        let sut = makeSUT(error: error)
        
        await sut.fetchLocations()
        
        XCTAssertEqual(sut.abnLocationsState, .error)
    }
}

private extension LocationsViewModelTests {
    func makeSUT(locations: [Location] = [], error: APIError? = nil, file: StaticString = #filePath, line: UInt = #line) -> LocationsViewModel {
        let api = SimpleAPIMock()
        api.locations = LocationsList(locations: locations)
        api.error = error
        
        let sut = LocationsViewModel(api: api)
        
        trackForMemoryLeaks(api, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return sut
    }
    
    var testLocations: [Location] {
        let list: LocationsList = DataFile.load("locationsData.json")
        return list.locations
    }
}
