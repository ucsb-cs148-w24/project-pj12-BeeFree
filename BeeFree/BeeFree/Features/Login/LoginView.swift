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
    @Published var uid:String = ""


    func signInGoogle(completion: @escaping (Bool) -> Void) async {
            do {
                guard let topVC = LoginUtilities.shared.topViewController() else {
                    throw URLError(.cannotFindHost)
                }
                let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
                guard let idToken = gidSignInResult.user.idToken?.tokenString else{
                    throw URLError(.badServerResponse)
                }
                let accessToken = gidSignInResult.user.accessToken.tokenString
                let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken)
                
                let authResult = try await AuthManager.shared.signInWithGoogle(tokens: tokens)
                
                // Check if the user exists in your database
                let userExists = try? await UserDB.shared.checkExistUser(uid: authResult.uid)
                isNewUser = !(userExists ?? false)
                uid = authResult.uid
                // If the user exists, complete the sign-in process
                if !isNewUser {
                    completion(true)
                }
                // For new users, defer the completion until the first name is submitted
            } catch {
                print(error)
                completion(false)
            }
        }

        // Function to submit the first name for new users
        func submitFirstName(completion: @escaping () -> Void) async {
            guard let user = try? await AuthManager.shared.getAuthUser(), !firstName.isEmpty else {
                return
            }
            
            do {
                try await UserDB.shared.createNewUser(auth: user, firstName: firstName)
                completion() // Complete the sign-in process after submitting the first name
            } catch {
                print(error)
            }
        }
    
//      func submitFirstName() async {
//        // logic to submit first name to firestore
//        guard let user = try? await AuthManager.shared.getAuthUser(), !firstName.isEmpty else {
//            return
//        }
//        
//        do{
//            try await UserDB.shared.createNewUser(auth: user, firstName: firstName)
//            
//        } catch {
//            print(error)
//        }
//
//    }
    
}



struct LoginView: View {
    @StateObject private var viewModel = LoginviewModel()
    @State var isAuthenticated = false
    @Binding var showSignInView: Bool
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image("app_logo") // Replace with your actual logo image name
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)

                if viewModel.isNewUser {
                    // Display for new users to enter their first name
                    Text("Welcome, New User!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 20)

                    Text("Please enter your first name to continue")
                        .font(.title3)
                        .foregroundColor(.gray)
                        .padding(.bottom, 30)

                    TextField("First Name", text: $viewModel.firstName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Button("Submit") {
                        Task {
                            await viewModel.submitFirstName {
                                isAuthenticated = true
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding()
                } else {
                    // Display for users to sign in
                    Text("Welcome to BeeFree")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 20)

                    Text("Please Sign in to continue")
                        .font(.title3)
                        .foregroundColor(.gray)
                        .padding(.bottom, 30)

                    // Google Sign-in Button
                    Button(action: {
                        Task {
                            await viewModel.signInGoogle { success in
                                isAuthenticated = success
                            }
                        }
                    }) {
                        HStack {
                            Image("google_icon") // Replace with your Google icon asset
                                .resizable()
                                .frame(width: 24, height: 24)
                            Text("Sign in with Google")
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .background(Color.blue)
                        .cornerRadius(8)
                    }
                    .padding()
                }
                NavigationLink(destination: ContentView()
                    .navigationBarBackButtonHidden(true),
                    isActive: $isAuthenticated) {
                    EmptyView()
                }
            }
            .padding()
            .navigationBarHidden(true)
        }
    }   
}

#Preview {
    LoginView(showSignInView: .constant(true))
}

