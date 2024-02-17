//
//  AddFriendView.swift
//  BeeFree
//
//  Created by Saeri on 2/17/24.
//

import Foundation
import SwiftUI

struct Friend: Identifiable {
    let id: UUID // Make sure your friend model has an id property
    var email: String
}

class FriendsViewModel: ObservableObject {
    @Published var friends: [Friend] = []
    
    func addFriend(email: String) {
        // Validate the email format
        guard isValidEmail(email) else {
            // Handle invalid email format
            return
        }
        
        // Check if the friend is already added or invited
        guard !friends.contains(where: { $0.email == email }) else {
            // Handle already added friend
            return
        }
        
        // Proceed with adding the friend
        // This might involve sending a request to your backend
        let newFriend = Friend(id: <#UUID#>, email: email)
        friends.append(newFriend)
        
        // Optionally, send invitation or notification to the friend
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        // Implement email validation logic
        // You can use regular expressions or other methods
    }
}

struct AddFriendView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @Binding var isDarkMode: Bool
    @State private var friendEmail = ""
    // Assuming you have a ViewModel to handle adding friends
    @ObservedObject var viewModel: FriendsViewModel

    var body: some View {
        VStack {
            TextField("Friend's Email", text: $friendEmail)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Add Friend") {
                viewModel.addFriend(email: friendEmail)
            }
            .padding()
            
            // Optionally, list added friends or pending invitations
            List(viewModel.friends) { friend in
                Text(friend.email)
            }
        }
        .navigationTitle("Add Friend")
    }
}

struct AddFriendView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a FriendsViewModel instance for the preview
        let viewModel = FriendsViewModel()
        
        // Provide a constant binding for the isDarkMode, since previews don't change
        AddFriendView(isDarkMode: .constant(false), viewModel: viewModel)
    }
}
