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
    
    /*func signInGoogle() async throws {
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

        
    }*/
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

/*struct LoginView: View {
    @StateObject private var viewModel = LoginviewModel()
    @State private var isAuthenticated = false
    @Binding var showSignInView: Bool

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // App Logo or Image
                Image("app_logo") // Replace with your actual logo image name
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)

                // Title or Welcome Text
                Text("Welcome to BeeFree")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)

                // Description or Subtitle
                Text("Please Sign in to continue")
                    .font(.title3)
                    .foregroundColor(.gray)
                    .padding(.bottom, 30)

                // Google Sign-in Button
                Button(action: {
                    Task {
                        do {
                            try await viewModel.signInGoogle()
                            isAuthenticated = true
                        } catch {
                            print(error)
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

                // Controlled NavigationLink
                NavigationLink(destination: ContentView(), isActive: $isAuthenticated) {
                    EmptyView()
                }
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}*/

struct LoginView: View {
    @StateObject private var viewModel = LoginviewModel()
    @State private var isAuthenticated = false
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

                // Controlled NavigationLink
                NavigationLink(destination: ContentView(), isActive: $isAuthenticated) {
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

/*struct LoginView: View {
    @StateObject private var viewModel = LoginviewModel()
    @State private var isAuthenticated = false // State to control navigation
    @Binding var showSignInView: Bool

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isNewUser {
                    TextField("Please enter your First Name", text: $viewModel.firstName)
                    Button("Submit") {
                        Task {
                            await viewModel.submitFirstName()
                            isAuthenticated = true // Set true after submitting first name
                        }
                    }
                } else {
                    Button("Sign in with Google") {
                        Task {
                            do {
                                try await viewModel.signInGoogle()
                                isAuthenticated = true // Set true after successful Google sign-in
                            } catch {
                                print(error)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding()
                }

                // Controlled NavigationLink
                NavigationLink(destination: ContentView(), isActive: $isAuthenticated) {
                    EmptyView()
                }
            }
        }
    }
}*/

/*
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
        
        do{
            let authResult = try await AuthManager.shared.signInWithGoogle(tokens: tokens)
            //self.isNewUser = try await UserDB.shared.checkExistUser(uid: authResult.uid) replaced by below
            let userExists = try? await UserDB.shared.checkExistUser(uid: authResult.uid)

            isNewUser = !(userExists ?? false)
            print("Login successful. isNewUser: \(isNewUser)")
        } catch {
            print("Error in signInGoogle: \(error)")
            throw error
        }
        

        
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
        NavigationView {
            VStack {
                if viewModel.isNewUser {
                    TextField("Please enter your First Name", text: $viewModel.firstName)
                    Button("Submit") {
                        Task {
                            await viewModel.submitFirstName()
                            showSummaryView = true
                        }
                    }
                } else {
                    GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
                        Task {
                            do {
                                try await viewModel.signInGoogle()
                                showSummaryView = true
                                print("Login and setting showSummary = true")
                            } catch {
                                print(error)
                            }
                        }
                    }
                    
                }
                
                // Debug button
                /* Button("Test Navigation to ContentView") {
                 print("Test Navigation button was tapped")
                 showSummaryView = true
                 
                 NavigationLink(destination: ContentView(), isActive: $showSummaryView) { ContentView() }
                 }
                 }
                 .navigationTitle("Login")
                 .navigationBarTitleDisplayMode(.inline)
                 NavigationLink(destination: ContentView(), isActive: $showSummaryView) { EmptyView() }
                 */
                
                NavigationView{
                    
                    NavigationLink(destination: {
                        ContentView()
                    }, label: {
                        Text("Press Me")
                            .foregroundColor(.white)  // Set the modifiers to your liking.
                            .padding(.vertical)
                            .padding(.horizontal, 50)
                            .background(.blue)
                            .cornerRadius(10)
                    })
                    .navigationTitle("Home")
                }
            }
//            .onAppear {
//                print("LoginView is now appearing")
//            }
//            .onDisappear {
//                print("LoginView is now disappearing")
//            }
        }
    }
}



#Preview {
    LoginView(showSignInView: .constant(true))
}
*/
