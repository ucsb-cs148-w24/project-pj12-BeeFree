//
//  LoginView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.
//

import SwiftUI
import FirebaseCore
import Firebase
import GoogleSignInSwift
import GoogleSignIn

struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String
}

@MainActor
final class LoginviewModel: ObservableObject{
    @Published var isNewUser = false
    @Published var firstName = ""
    
    func signInGoogle() async throws {
        guard let topVC = LoginUtilities.shared.topViewController()else{
            throw URLError(.cannotFindHost)
        }
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        guard let idToken = gidSignInResult.user.idToken?.tokenString else{
            throw URLError(.badServerResponse)
        }
        let accessToken = gidSignInResult.user.accessToken.tokenString
        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken)
        try await AuthManager.shared.signInWithGoogle(tokens: tokens)
        
        let authResult = try await AuthManager.shared.signInWithGoogle(tokens: tokens)
        
        //self.isNewUser = try await UserDB.shared.checkExistUser(uid: authResult.uid) replaced by below
        let userExists = try? await UserDB.shared.checkExistUser(uid: authResult.uid)

        isNewUser = !(userExists ?? false)

        
    }
    
      func submitFirstName() async {
        // logic to submit first name to firestore
        guard let user = try? await AuthManager.shared.getAuthUser(), !firstName.isEmpty else {
            return
        }
        
        do{
            try await UserDB.shared.createNewUser(auth: user, firstName: firstName)
            
        } catch {
            print(error)
        }

    }
    
}
struct LoginView: View {
    @StateObject private var viewModel = LoginviewModel()
    @State private var showSummaryView = false
    @Binding var showSignInView: Bool
    var body: some View {
        NavigationView{
            VStack {
                if viewModel.isNewUser {
                    TextField("Please enter your First Name", text: $viewModel.firstName)
                    Button("Submit"){
                        Task {
                            await viewModel.submitFirstName()
                            showSummaryView = true
                            
                        }
                    }
                } else {
                    GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)){
                        Task{
                            do{
                                try await viewModel.signInGoogle()
                                showSummaryView = true
                            }catch{
                                print(error)
                            }
                        }
                    }
                }
                
            }
            
            NavigationLink(destination: ContentView(), isActive: $showSummaryView) {EmptyView()}

        }
        
    }
}

#Preview {
    LoginView(showSignInView: .constant(true))
}


