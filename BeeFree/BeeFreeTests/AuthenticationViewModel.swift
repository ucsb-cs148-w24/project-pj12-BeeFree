//
//  AuthenticationViewModel.swift
//  BeeFree
//
//  Created by Mike Wang on 2/23/24.
//

import Foundation
class AuthenticationViewModel {
    var authService: FirebaseAuthServiceProtocol

    init(authService: FirebaseAuthServiceProtocol) {
        self.authService = authService
    }

    func loginWithGoogle(completion: @escaping (Result<User, Error>) -> Void) {
        authService.loginWithGoogle(completion: completion)
    }
}
