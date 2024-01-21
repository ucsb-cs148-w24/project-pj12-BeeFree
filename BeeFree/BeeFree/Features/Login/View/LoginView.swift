//
//  LoginView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.
//

import SwiftUI
import FirebaseCore

struct LoginView: View {
    var body: some View {
        NavigationStack {
            VStack {
                // image
                Image(systemName: "timelapse")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50, alignment: .center)
                    .padding(EdgeInsets(top: 128, leading: 16, bottom: 16, trailing: 16))
                    .foregroundColor(.yellow)
                // form fields
                
                // sign in button
                                
                Spacer()
                
                // sign up button
                Text("Sign Up")
                    .bold()
                    .foregroundColor(.yellow)
                    .padding(EdgeInsets(top: 128, leading: 16, bottom: 64, trailing: 16))
            }
        }
    }
}

#Preview {
    LoginView()
}

