//
//  LocationView.swift
//  ABNAssessment
//
//  Created by Jolanda Arends on 04/03/2024.
//

import SwiftUI

struct LocationView: View {
    let location: Location
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(location.name ?? "Unknown")
                .font(.headline)
                .padding(.bottom, 4)
            Group {
                Text("Lat: \(location.lat)")
                Text("Long: \(location.long)")
            }
            .font(.body)
        }
        .accessibilityLabel("Location \(location.name ?? "Unknown"), with coordinates: \(location.lat) latitude, and \(location.long) longitude.")
    }
}

#if DEBUG
private var locationsList: LocationsList = DataFile.load("locationsData.json")

#Preview {
    Group {
        LocationView(location: locationsList.locations[0])
        LocationView(location: locationsList.locations[3])
    }
    .preferredColorScheme(.light)
}

#Preview {
    Group {
        LocationView(location: locationsList.locations[0])
        LocationView(location: locationsList.locations[3])
    }
    .preferredColorScheme(.dark)
}
#endif
