////
////  welcomeViewController.swift
////  BeeFree
////
////  Created by Mike Wang on 1/31/24.
////
//
//import Foundation
//import UIKit
//import SwiftUI
//import DeviceActivity
//import FamilyControls
//import ManagedSettings
//
//class WelcomeViewController: UIViewController{
//    @available(iOSApplicationExtension, unavailable)
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.view.backgroundColor = UIColor.red
//        let loginView = LoginView(showSignInView: .constant(false), isDarkMode: <#T##Bool#>).edgesIgnoringSafeArea(.all)
//        let hostingController = UIHostingController(rootView: loginView)
//        
//        // Add the hosting controller as a child of the view controller
//        addChild(hostingController)
//        view.addSubview(hostingController.view)
//        hostingController.didMove(toParent: self)
//
//        // Set up constraints or frame to respect safe area
//        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            hostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            hostingController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            hostingController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            hostingController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//        ])
//
//        
//    }
//
//}
