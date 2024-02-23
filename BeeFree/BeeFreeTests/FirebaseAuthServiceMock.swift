//
//  FirebaseAuthServiceMock.swift
//  BeeFree
//
//  Created by Mike Wang on 2/23/24.
//

import Foundation
import FirebaseCore
import Firebase
import GoogleSignInSwift
import GoogleSignIn
@testable import BeeFree

// Define a simple user model for demonstration purposes
struct User {
    var email: String
    var isNewUser: Bool
}

// Protocol to abstract the authentication service
protocol FirebaseAuthServiceProtocol {
    func loginWithGoogle(completion: @escaping (Result<User, Error>) -> Void)
}



class FirebaseAuthServiceMock: FirebaseAuthServiceProtocol {
    var isUserNew: Bool = true // You can toggle this to simulate different scenarios

    func loginWithGoogle(completion: @escaping (Result<User, Error>) -> Void) {
        if isUserNew {
            // Simulate adding a new user's email to the database
            completion(.success(User(email: "newuser@example.com", isNewUser: true)))
        } else {
            // Simulate fetching existing user data
            completion(.success(User(email: "existinguser@example.com", isNewUser: false)))
        }
    }
}
