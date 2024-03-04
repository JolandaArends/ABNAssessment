//
//  LocationsView.swift
//  ABNAssessment
//
//  Created by Jolanda Arends on 04/03/2024.
//

import SwiftUI

struct LocationsView: View {
    var body: some View {
        NavigationView {
            VStack {
                screenHeader
                
                List {
                    abnLocationsSection
                }
                .listStyle(.insetGrouped)
            }
            .navigationTitle("Locations")
        }
    }
}

private extension LocationsView {
    private var locations: LocationsList {
        return DataFile.load("locationsData.json")
    }
    
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
            ForEach(locations.locations, id: \.self) { location in
                LocationView(location: location)
            }
        }
    }
}

#if DEBUG
#Preview {
    LocationsView()
        .preferredColorScheme(.light)
}

#Preview {
    LocationsView()
        .preferredColorScheme(.dark)
}
#endif
