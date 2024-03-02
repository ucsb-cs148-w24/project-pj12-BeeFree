//
//  NewUserView.swift
//  BeeFree
//
//  Created by Hongye Liang on 1/26/24.
//
/*
import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct NewUserView: View {
    @State private var firstName: String = ""
    @EnvironmentObject var viewModel: LoginviewModel // Assumes LoginviewModel has necessary methods

    var body: some View {
        VStack {
            TextField("Enter First Name", text: $firstName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Submit") {
                Task {
                    await submitFirstName()
                }
            }
            .padding()
        }
    }

    private func submitFirstName() async {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        // Update Firestore with the new user's first name
        let db = Firestore.firestore()
        let userDocument = db.collection("BeFreeUsers").document(userID)

        do {
            try await userDocument.setData(["firstName": firstName], merge: true)
            // Handle the transition to the main app view or update state as needed
        } catch {
            print("Error updating user: \(error)")
            // Handle the error appropriately
        }
    }
}

struct NewUserView_Previews: PreviewProvider {
    static var previews: some View {
        NewUserView().environmentObject(LoginviewModel())
    }
}
*/
