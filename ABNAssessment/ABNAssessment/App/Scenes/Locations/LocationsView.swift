//
//  LocationsView.swift
//  ABNAssessment
//
//  Created by Jolanda Arends on 04/03/2024.
//

import SwiftUI
import CoreLocation

struct LocationsView: View {
    @ObservedObject var viewModel: LocationsViewModel
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        NavigationView {
            VStack {
                screenHeader
                
                List {
                    customLocationSection
                    abnLocationsSection
                }
                .listStyle(.insetGrouped)
                .task {
                    await viewModel.fetchLocations()
                }
                // It's always important to allow the user to recover from a failure or mistatek
                .refreshable {
                    Task { await viewModel.fetchLocations() }
                }
            }
            .navigationTitle("Locations")
        }
    }
}

private extension LocationsView {
    var screenHeader: some View {
        Text("Pick a location and look it up in the Wikipedia app. You can choose from a provided set of locations or pick your own.")
            .font(.body)
            .padding(.horizontal)
    }
    
    var customLocationSection: some View {
        Section(header:
            Text("My location")
                .foregroundColor(.accentColor)
        ) {
            NavigationLink(
                destination: PickLocationView(),
                label: {
                    Text("Open map to pick your own location")
                })
        }
    }
    
    var abnLocationsSection: some View {
        Section(header:
            Text("ABN locations")
                .foregroundColor(.accentColor)
        ) {
            switch viewModel.abnLocationsState {
            case .loading:
                ProgressView()
            case .empty:
                Text("No locations found at ABN")
            case .error:
                Text("Something went wrong. Please try again by refreshing the list.")
            case .results:
                ForEach(viewModel.locations, id: \.self) { location in
                    accessibleLocationRowView(location)
                }
            }
        }
    }
    
    func accessibleLocationRowView(_ location: Location) -> some View {
        // Wrapping it in a button is better for accessibility
        Button(action: {
            openPlacesDeeplink(location)
        }) {
            // Needs a little hack to make entire row tappable (instead of just text), because we're using a buttonStyle.
            HStack {
                LocationView(location: location)
                Spacer()
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
    
    func openPlacesDeeplink(_ location: Location) {
        let coordinates = CLLocationCoordinate2D(latitude: location.lat,
                                                 longitude: location.long)
        guard let deepLink = DeepLink.createPlacesDeepLinkWithCoordinates(for: coordinates) else { return }
        openURL(deepLink)
    }
}

#if DEBUG
#Preview {
    LocationsView(viewModel: LocationsViewModel())
        .preferredColorScheme(.light)
}

#Preview {
    LocationsView(viewModel: LocationsViewModel())
        .preferredColorScheme(.dark)
}
#endif
