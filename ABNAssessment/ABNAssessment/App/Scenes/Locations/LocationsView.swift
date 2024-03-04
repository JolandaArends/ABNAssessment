//
//  LocationsView.swift
//  ABNAssessment
//
//  Created by Jolanda Arends on 04/03/2024.
//

import SwiftUI

struct LocationsView: View {
    @ObservedObject var viewModel: LocationsViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                screenHeader
                
                List {
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
        Text("Pick a location and look it up in the Wikipedia app. You can choose from a provided set of locations.")
            .font(.body)
            .padding(.horizontal)
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
                    Button(action: {
                        print("open Wikipedia app for location")
                    }) {
                        LocationView(location: location)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
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
