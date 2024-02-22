import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseCore
import FirebaseAuth

struct Friend: Identifiable {
    let id: UUID
    var email: String
    var firstName: String
}

class FriendsViewModel: ObservableObject {
    @Published var friends: [Friend] = []

    var currentUserID: String? {
        Auth.auth().currentUser?.uid
    }

    func addFriend(email: String, completion: @escaping (Bool) -> Void) {
        guard let userID = currentUserID else {
            completion(false)
            return
        }

        guard isValidEmail(email: email), !friends.contains(where: { $0.email == email }) else {
            completion(false)
            return
        }

        UserDB.shared.fetchUserByEmail(email: email) { [weak self] firstName in
            guard let self = self, let firstName = firstName else {
                completion(false)
                return
            }

            let newFriend = Friend(id: UUID(), email: email, firstName: firstName)
            self.friends.append(newFriend)

            UserDB.shared.addFriendToUser(userID: userID, friendFirstName: firstName)
            completion(true)
        }
    }

    // Method to validate email format
    private func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}



struct AddFriendView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @Binding var isDarkMode: Bool
    @State private var friendEmail = ""
    @State private var friendAddedSuccess: Bool?
    @ObservedObject var viewModel: FriendsViewModel

    var body: some View {
        VStack {
            TextField("Friend's Email", text: $friendEmail)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Add Friend") {
                viewModel.addFriend(email: friendEmail) { success in
                    friendAddedSuccess = success
                }
            }
            .padding()

            // Display feedback message
            if let friendAdded = friendAddedSuccess {
                Text(friendAdded ? "Friend added successfully!" : "Failed to add friend. Please enter a valid email.")
                    .foregroundColor(friendAdded ? .green : .red)
                    .padding()
            }

            Spacer()

            Button("Done") {
                dismiss()
            }
            .padding()
        }
        .navigationTitle("Add Friend")
    }
}



struct AddFriendView_Previews: PreviewProvider {
    static var previews: some View {
        AddFriendView(isDarkMode: .constant(false), viewModel: FriendsViewModel())

    }
}
