//
//  BeeFreeApp.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAppCheck
import FamilyControls
import DeviceActivity
import ManagedSettings
import UserNotifications
import UserNotificationsUI

@main
struct BeeFreeApp: App {
    init() {
        FirebaseApp.configure()
        let providerFactory = AppCheckDebugProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
    }

    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    let authcenter = AuthorizationCenter.shared

    var body: some Scene {
        WindowGroup {
            ZStack { /*ContentView(isDarkMode: false)*/ LoginView(isDarkMode: false, showSignInView: .constant(true)) }
                .onAppear {
                    Task {
                        do {
                            try await authcenter.requestAuthorization(for: .individual)
                        } catch {
                            print("Failed to enroll user with error: \(error)")
                        }
                    }
                }
        }
    }
//    var body: some Scene {
//        WindowGroup {
//            ZStack { ContentView(isDarkMode: false) }
//                .onAppear {
//                    Task {
//                        do {
//                            try await authcenter.requestAuthorization(for: .individual)
//                        } catch {
//                            print("Failed to enroll user with error: \(error)")
//                        }
//                    }
//                }
//        }
//    }
}


//struct viewControllerWrapper :UIViewControllerRepresentable{
//    func makeUIViewController(context: Context) -> some UIViewController {
//        WelcomeViewController()
//    }
//    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//
//    }
//}

class AppDelegate: NSObject, UIApplicationDelegate {
    // Make this request when the app launches
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        BeeFreeSchedule.setSchedule()
        return true
    }
}
