//
//  welcomeViewController.swift
//  BeeFree
//
//  Created by Mike Wang on 1/31/24.
//

import Foundation
import UIKit
import SwiftUI
import DeviceActivity
import FamilyControls
import ManagedSettings

class WelcomeViewController: UIViewController{
    @available(iOSApplicationExtension, unavailable)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubViews()
        setupSwipe()
    }
    
    @available(iOSApplicationExtension, unavailable)
    private func setupSubViews(){
        let logoImageView = UIImageView(image: UIImage(named:"TransparentImage"))
        logoImageView.contentMode = .scaleAspectFit
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        let welcomeLabel = UILabel()
        welcomeLabel.text = "Welcome to Bee Free!"
        welcomeLabel.textAlignment = .center
        welcomeLabel.numberOfLines = 0
        welcomeLabel.textColor = UIColor(Color("Sky"))
        view.addSubview(welcomeLabel)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.bottomAnchor.constraint(equalTo: logoImageView.topAnchor, constant: -20), // Adjust constant for your layout
        ])
        
        let swipeLabel = UILabel()
        swipeLabel.text = "Swipe up to continue"
        swipeLabel.textAlignment = .center
        swipeLabel.numberOfLines = 0 // Allows for multiple lines
        swipeLabel.textColor = UIColor(Color("DynamicGray"))
        view.addSubview(swipeLabel)
        swipeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Set constraints for the swipe up label
        NSLayoutConstraint.activate([
            swipeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            swipeLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30) // Adjust constant for your layout
        ])
    }
    
    @available(iOSApplicationExtension, unavailable)
    private func setupSwipe(){
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeUp))
        swipeUpGesture.direction = .up
        view.addGestureRecognizer(swipeUpGesture)
    }
    
    @objc private func handleSwipeUp() {
        // Transition to the LoginView
        let loginView = LoginView(showSignInView: .constant(false))
        let hostingController = UIHostingController(rootView: loginView)
        hostingController.modalPresentationStyle = .fullScreen
        hostingController.modalTransitionStyle = .coverVertical
        present(hostingController, animated: true, completion: nil)
    }
}
