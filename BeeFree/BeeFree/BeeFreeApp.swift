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

@main
struct BeeFreeApp: App {
    init() {
        // Configure Firebase
        FirebaseApp.configure()
        
        // Initialize the App Check with the debug provider
        let providerFactory = AppCheckDebugProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
    }
    
    var body: some Scene {
        WindowGroup {
                viewControllerWrapper()
        }
    }
}


struct viewControllerWrapper :UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> some UIViewController {
        welcomeViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
