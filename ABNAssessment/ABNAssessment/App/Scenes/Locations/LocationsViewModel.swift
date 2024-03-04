//
//  LocationsViewModel.swift
//  ABNAssessment
//
//  Created by Jolanda Arends on 04/03/2024.
//

import Foundation
import SwiftUI

final class LocationsViewModel: ObservableObject {
    @Published var abnLocationsState: ViewState = .loading
    @Published var locations: [Location] = []
    
    private let api: SimpleDataFetcher
    
    init(api: SimpleDataFetcher = SimpleAPI()) {
        self.api = api
    }
    
    @MainActor
    func fetchLocations() async {
        do {
            abnLocationsState = .loading
            let locationsList = try await api.fetchLocations()
            // Map results from API to something the UI can handle. In this case we don't need a complicated mapper.
            locations = locationsList.locations
            withAnimation {
                abnLocationsState = locations.isEmpty ? .empty : .results
            }
        } catch {
            // We could check the error coming back here and adjust the UI (flow) appropriately.
            // For this assessment we just tell the user to retry.
            locations = []
            abnLocationsState = .error
        }
    }
}
