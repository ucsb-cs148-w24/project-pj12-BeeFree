/*import Foundation
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
    @Published var currentUserFirstName: String? = nil


    var currentUserID: String? {
        Auth.auth().currentUser?.uid
    }
    
    func fetchCurrentUserName() {
        guard let userID = currentUserID else {
            print("User not logged in")
            return
        }

        UserDB.shared.getUser(userid: userID) { [weak self] (userinfo: Userinfo?) in
            guard let self = self, let userinfo = userinfo else {
                print("Failed to fetch user info or user info not found")
                return
            }
            self.currentUserFirstName = userinfo.firstName
        }
    }

    /*func addFriend(email: String, completion: @escaping (Bool) -> Void) {
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
    }*/
    func addFriend(email: String, completion: @escaping (Bool) -> Void) {
        guard let userID = currentUserID else {
            completion(false)
            return
        }

        guard isValidEmail(email: email), !friends.contains(where: { $0.email == email }) else {
            completion(false)
            return
        }

        UserDB.shared.fetchUserByEmail(email: email) { [weak self] userinfo in
            guard let self = self, let userinfo = userinfo else {
                completion(false)
                return
            }

            let newFriend = Friend(id: UUID(), email: email, firstName: userinfo.firstName ?? "Unknown")
            self.friends.append(newFriend)

            UserDB.shared.addFriendToUser(userID: userID, friendFirstName: userinfo.firstName ?? "Unknown")
            completion(true)
        }
    }


    // Method to validate email format
    private func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func fetchCurrentUserFriends() {
        guard let userID = currentUserID else {
            print("User not logged in")
            return
        }

        UserDB.shared.getFriendsOfUser(userID: userID) { [weak self] friendsEmails in
            guard let self = self else {
                print("Time to make new friends!")
                return
            }

            for email in friendsEmails {
                UserDB.shared.fetchUserByEmail(email: email) { friendInfo in
                    if let firstName = friendInfo?.firstName {
                        let friend = Friend(id: UUID(), email: email, firstName: firstName)
                        self.friends.append(friend)
                    }
                }
            }
        }
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
            // Text field for adding a new friend
            TextField("Friend's Email", text: $friendEmail)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // Button to add a friend
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
            
            // Personalized greeting
            if let firstName = viewModel.currentUserFirstName {
                Text("Dear \(firstName), here is your list of friends:")
                    .font(.title2)
                    .padding([.top, .bottom])
            }

            // Display list of friends
            List(viewModel.friends) { friend in
                VStack(alignment: .leading) {
                    Text("Name: \(friend.firstName)")
                    Text("Email: \(friend.email)")
                }
            }

            Spacer()

            Button("Done adding friends") {
                dismiss()
            }
            .padding()
        }
        .navigationTitle("Add Friend")
        .onAppear {
            viewModel.fetchCurrentUserFriends()
            viewModel.fetchCurrentUserName()
        }
    }
}

struct AddFriendView_Previews: PreviewProvider {
    static var previews: some View {
        AddFriendView(isDarkMode: .constant(false), viewModel: FriendsViewModel())
    }
}

*/

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
    @Published var currentUserFirstName: String? = nil


    var currentUserID: String? {
        Auth.auth().currentUser?.uid
    }
    
    func fetchCurrentUserName() {
            guard let userID = currentUserID else {
                print("User not logged in")
                return
            }

            UserDB.shared.getUser(userid: userID) { [weak self] (userinfo: Userinfo?) in
                guard let self = self, let userinfo = userinfo else {
                    print("Failed to fetch user info or user info not found")
                    return
                }
                self.currentUserFirstName = userinfo.firstName
            }
        }

//    func addFriend(email: String, completion: @escaping (Bool) -> Void) {
//        guard let userID = currentUserID else {
//            completion(false)
//            return
//        }
//
//        guard isValidEmail(email: email), !friends.contains(where: { $0.email == email }) else {
//            completion(false)
//            return
//        }
//
//        UserDB.shared.fetchUserByEmail(email: email) { [weak self] firstName in
//            guard let self = self, let firstName = firstName else {
//                completion(false)
//                return
//            }
//
//            let newFriend = Friend(id: UUID(), email: email, firstName: firstName)
//            self.friends.append(newFriend)
//
//            UserDB.shared.addFriendToUser(userID: userID, friendFirstName: firstName)
//            completion(true)
//        }
//    }
    func addFriend(email: String, completion: @escaping (Bool) -> Void) {
        guard let userID = currentUserID else {
            completion(false)
            return
        }

        guard isValidEmail(email: email), !friends.contains(where: { $0.email == email }) else {
            completion(false)
            return
        }

        UserDB.shared.fetchUserByEmail(email: email) { [weak self] userinfo in
            guard let self = self, let userinfo = userinfo else {
                completion(false)
                return
            }

            let newFriend = Friend(id: UUID(), email: email, firstName: userinfo.firstName ?? "Unknown")
            self.friends.append(newFriend)

            UserDB.shared.addFriendToUser(userID: userID, friendFirstName: userinfo.firstName ?? "Unknown")
            completion(true)
        }
    }


    // Method to validate email format
    private func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func fetchCurrentUserFriends() {
            guard let userID = currentUserID else {
                print("User not logged in")
                return
            }

            UserDB.shared.getFriendsOfUser(userID: userID) { [weak self] friendsList in
                guard let self = self else {
                    print("Time to make new friends!")
                    return
                }
                
                self.friends = friendsList.map { Friend(id: UUID(), email: $0, firstName: $0) }

            }
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
            // Text field for adding a new friend
            TextField("Friend's Email", text: $friendEmail)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .autocapitalization(.none)

            // Button to add a friend
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
            
            // Personalized greeting
            if let firstName = viewModel.currentUserFirstName {
                if viewModel.friends.isEmpty{
                    Text("Time to make new friends!")
                        .font(.title2)
                        .padding([.top, .bottom])
                }else{
                    Text("Dear \(firstName), here is your list of friends:")
                        .font(.title2)
                        .padding([.top, .bottom])
                }

            }

            List(viewModel.friends) { friend in
                VStack(alignment: .leading) {
                    Text("Name: \(friend.firstName)")
                    //Text("Email: \(friend.email)")
                }
            }
            Spacer()

            Button("Done adding friends") {
                dismiss()
            }
            .padding()
        }
        .navigationTitle("Add Friend")
        .onAppear {
            viewModel.fetchCurrentUserFriends()
            viewModel.fetchCurrentUserName()
        }
    }
}

struct AddFriendView_Previews: PreviewProvider {
    static var previews: some View {
        // Sample preview with mock data or bindings
        AddFriendView(isDarkMode: .constant(false), viewModel: FriendsViewModel())
    }
}
