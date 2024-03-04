//
//  ABNAssessmentApp.swift
//  ABNAssessment
//
//  Created by Jolanda Arends on 04/03/2024.
//

import SwiftUI

@main
struct ABNAssessmentApp: App {
    @StateObject var locationsViewModel = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView(viewModel: locationsViewModel)
        }
    }
}
