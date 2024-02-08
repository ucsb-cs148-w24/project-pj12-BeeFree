//
//  BeeFreeApp.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.
//

import SwiftUI
import FirebaseCore
import Firebase
import FirebaseAppCheck
import FamilyControls

@main
struct BeeFreeApp: App {
    init() {
        // Configure Firebase
        FirebaseApp.configure()
        
        // Initialize the App Check with the debug provider
        let providerFactory = AppCheckDebugProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
    }
    
    let center = AuthorizationCenter.shared
    var body: some Scene {
        WindowGroup {
            ZStack {
                viewControllerWrapper()
            }
        }
    }
}


struct viewControllerWrapper :UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> some UIViewController {
        WelcomeViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
