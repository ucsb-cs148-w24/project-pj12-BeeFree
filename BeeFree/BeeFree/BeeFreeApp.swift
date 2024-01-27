//
//  BeeFreeApp.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.
//

import SwiftUI
import FamilyControls

@main
struct BeeFreeApp: App {
    let center = AuthorizationCenter.shared
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
            }
            .onAppear {
                Task {
                    do {
                        try await center.requestAuthorization(for: .individual)
                    } catch {
                        print("Failed to enroll user with error: \(error)")
                    }
                }
            }
        }
    }
}
