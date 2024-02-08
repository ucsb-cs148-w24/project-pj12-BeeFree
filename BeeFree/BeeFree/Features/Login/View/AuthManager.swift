//
//  AuthManager.swift
//  BeeFree
//
//  Created by Mike Wang on 1/23/24.
//

import Foundation
import FirebaseCore
import Firebase
import GoogleSignInSwift
import GoogleSignIn
import FirebaseAuth

struct AuthDataResultModel{
    let uid: String
    let email: String?
    let displayName: String?
    
    init(user:User){
        self.uid = user.uid
        self.email = user.email
        self.displayName = user.displayName
    }
}

final class AuthManager{
    static let shared = AuthManager()
    private init(){}
    
    func getAuthUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else{
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResultModel(user: user)
    }
    
    func signOut() throws{
        try Auth.auth().signOut()
    }
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel{
        
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await signIn(credential: credential)
    }
    
    func signIn(credential: AuthCredential) async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().signIn(with: credential)
        
        //try await UserDB.shared.createNewUser(auth: authDataResult)
        return AuthDataResultModel(user: authDataResult.user)
    }
}
