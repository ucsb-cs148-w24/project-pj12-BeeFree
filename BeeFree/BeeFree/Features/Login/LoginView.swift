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
    let googleProfileImageUrl: String?
}

@available(iOSApplicationExtension, unavailable)

@MainActor
final class LoginviewModel: ObservableObject{
    @Published var isNewUser = false
    @Published var firstName = ""
    @Published var uid:String = ""
    var googleProfileImageUrl: String?

    @available(iOSApplicationExtension, unavailable)
    func signInGoogle(completion: @escaping (Bool) -> Void) async {
        do {
            guard let topVC = LoginUtilities.shared.topViewController() else {
                throw URLError(.cannotFindHost)
            }
            let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)

            let idToken = gidSignInResult.user.idToken?.tokenString ?? ""
            let accessToken = gidSignInResult.user.accessToken.tokenString

            let profileImageUrl = gidSignInResult.user.profile?.imageURL(withDimension: 200)?.absoluteString
            self.googleProfileImageUrl = profileImageUrl

            let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken, googleProfileImageUrl: profileImageUrl)
            
            let authResult = try await AuthManager.shared.signInWithGoogle(tokens: tokens)
            
            let userExists = try await UserDB.shared.checkExistUser(uid: authResult.uid)
            isNewUser = !(userExists ?? false)
            uid = authResult.uid

            completion(!isNewUser)
        } catch {
            print(error)
            completion(false)
        }
    }



    
    func submitFirstName(completion: @escaping (Bool) -> Void) async {
        guard let user = try? await AuthManager.shared.getAuthUser(), !firstName.isEmpty else {
            completion(false)
            return
        }

        let googleProfileImageUrl = self.googleProfileImageUrl ?? "" // Use default value if nil
        let isFirstNameAvailable = await UserDB.shared.createNewUser(auth: user, firstName: firstName, googleProfileImageUrl: googleProfileImageUrl)
        completion(isFirstNameAvailable)
    }


    
}


@available(iOSApplicationExtension, unavailable)
struct LoginView: View {
    @StateObject private var viewModel = LoginviewModel()
    @State var isAuthenticated = false
    @State private var errorMessage: String?
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

                    Text("Please enter your first name/username to continue")
                        .font(.title3)
                        .foregroundColor(.gray)
                        .padding(.bottom, 30)

                    TextField("First Name", text: $viewModel.firstName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocapitalization(.none)

                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    Button("Submit") {
                        Task {
                            await viewModel.submitFirstName { success in
                                if success {
                                    isAuthenticated = true
                                    errorMessage = nil
                                } else {
                                    isAuthenticated = false
                                    errorMessage = "This name is already taken. Please choose favorite name."
                                }
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
                NavigationLink(destination: ContentView(isDarkMode: false)
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
