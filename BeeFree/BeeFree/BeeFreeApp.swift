//
//  BeeFreeApp.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.
//

import SwiftUI
import FirebaseCore
import Firebase
@main
struct BeeFreeApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView(showSignInView: .constant(true))
        }
    }
}
