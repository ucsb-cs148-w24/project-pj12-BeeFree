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
    @State var isDarkMode : Bool
    @State private var errorMessage: String?
    @Binding var showSignInView: Bool
    
    var body: some View {

            NavigationView {
                ZStack{
                    LinearGradient(gradient: Gradient(colors:[Color("LighterSky"), Color("Sky")]), startPoint:.top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                    VStack(spacing: 20) {
                        Image("TransparentImage") // Replace with your actual logo image name
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150)
                        
                        if viewModel.isNewUser {
                            ZStack {
                                Rectangle()
                                    .fill(Color(.systemBackground))
                                    .opacity(0.25)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 300)
                                    .cornerRadius(10.0)
                                    .padding()
                                // Display for new users to enter their first name
                                VStack {
                                    Text("Welcome, new user!")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .padding(.bottom, 32)
                                        .foregroundColor(.white)
                                    
                                    Text("Please enter a username")
                                        .font(.title3)
                                        .foregroundColor(.white)
                                        .padding(.bottom, 16)
                                        .multilineTextAlignment(.center)
                                    
                                    TextField("Username", text: $viewModel.firstName)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding(EdgeInsets(top: 0, leading: 32, bottom: 16, trailing: 32))
                                        .autocapitalization(.none)
                                }
                            }
                            
                            
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
                                            errorMessage = "This username is already taken. Please try another name."
                                        }
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: 44)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("DynamicYellow"))
                            )
                            .padding(EdgeInsets(top: 16, leading: 50, bottom: 76, trailing: 50))
                            .foregroundColor(.white)
                            //                        .padding()
                        } else {
                            // Display for users to sign in
                            HStack {
                                Text("Welcome to")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 20)
                                    .foregroundColor(.white)
                                Text("BeeFree")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 20)
                                    .foregroundColor(.white)
                            }
                            
//                            Text("Please Sign in to continue")
//                                .font(.title3)
//                                .foregroundColor(.white)
//                                .padding(.bottom, 30)
//                            
                            // Google Sign-in Button
                            Button(action: {
                                Task {
                                    
                                    await viewModel.signInGoogle { success in
                                        isAuthenticated = success
                                    }
                                }
                            }) {
                                HStack {
                                    Image("googleIcon")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                    Text("Sign in with Google")
                                        .foregroundColor(.white)
                                }
                                .frame(maxWidth: .infinity, maxHeight: 44)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(.systemBackground))
                                        .opacity(0.5)
                                )
                                .padding(EdgeInsets(top: 16, leading: 50, bottom: 76, trailing: 50))
                            }
                            //                        .padding()
                        }
                        NavigationLink(destination: ContentView(isDarkMode: false)
                            .navigationBarBackButtonHidden(true),
                                       isActive: $isAuthenticated) {
                            EmptyView()
                        }
                    }
                    //                .padding()
                    .navigationBarHidden(true)
                    .background(.clear)
                    
                }
                .background(LinearGradient(gradient: Gradient(colors:[Color("LighterSky"), Color("Sky")]), startPoint:.top, endPoint: .bottom).edgesIgnoringSafeArea(.all))

            }
                

    }
}
