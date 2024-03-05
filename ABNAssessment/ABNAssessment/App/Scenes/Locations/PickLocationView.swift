//
//  PickLocationView.swift
//  ABNAssessment
//
//  Created by Jolanda Arends on 04/03/2024.
//

import SwiftUI
import MapKit

struct PickLocationView: View {
    @Environment(\.openURL) private var openURL
    
    // Start at ABN Amro office
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.33714,
                                                                                  longitude: 4.87465),
                                                   span: MKCoordinateSpan(latitudeDelta: 0.005,
                                                                          longitudeDelta: 0.005))
    
    var body: some View {
        NavigationView {
            VStack(spacing: 8) {
                map
                coordinates
                wikipediaButton
        
                Spacer()
            }
        }
        .navigationTitle("Pick Location")
    }
}

private extension PickLocationView {
   var map: some View {
       ZStack {
           Map(coordinateRegion: $region)
               .frame(maxWidth: .infinity, maxHeight: 400)
           
           Image(systemName: "mappin")
               .foregroundColor(.accentColor)
       }
    }
    
    var coordinates: some View {
        Text("Current coordinates:\n \(region.center.latitude), \(region.center.longitude)")
            .multilineTextAlignment(.center)
    }
    
    var wikipediaButton: some View {
        Button("Open in Wikipedia app") {
            openPlacesDeeplink(region.center)
        }
        .buttonStyle(.bordered)
    }
    
    func openPlacesDeeplink(_ location: CLLocationCoordinate2D) {
        guard let deepLink = DeepLink.createPlacesDeepLinkWithCoordinates(for: location) else { return }
        openURL(deepLink)
    }
}

#if DEBUG
#Preview {
    PickLocationView()
        .preferredColorScheme(.light)
}

#Preview {
    PickLocationView()
        .preferredColorScheme(.dark)
}
#endif
