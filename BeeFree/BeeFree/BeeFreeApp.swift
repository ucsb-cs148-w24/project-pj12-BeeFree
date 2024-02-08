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
import DeviceActivity
import ManagedSettings

@main
struct BeeFreeApp: App {
    init() {
        // Configure Firebase
        FirebaseApp.configure()
        
        // Initialize the App Check with the debug provider
        let providerFactory = AppCheckDebugProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
    };
    
    //@UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    let center = AuthorizationCenter.shared
    
    @StateObject var store = ManagedSettingsStore()
    @StateObject var model = BeeFreeModel.shared
    
    var body: some Scene {
        WindowGroup {
            VStack{
                ContentView()
                    .environmentObject(model)
                    .environmentObject(store)
            }
            .onAppear {
                Task {
                    do { try await center.requestAuthorization(for: .individual)
                    } catch {print("Failed to enroll user with error: \(error)")}
                }
            }
            // ZStack {viewControllerWrapper()}
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

//class AppDelegate: NSObject, UIApplicationDelegate {
//    // Make this request when the app launches
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        BeeFreeSchedule.setSchedule()
//        return true
//    }
//}
