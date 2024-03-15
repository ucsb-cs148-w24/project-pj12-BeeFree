//
//  AddFriendView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.
//

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
    var screenTimeGoal: Double?
    var userScreenTime: (hours: Int, minutes: Int)?

}

extension Friend {
    func calculateProgress(goalHours: Double) -> Double {
        let totalHours = Double(userScreenTime?.hours ?? 0) + Double(userScreenTime?.minutes ?? 0) / 60.0
        return totalHours / goalHours
    }
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

    
    func addFriend(email: String, completion: @escaping (Bool) -> Void) {
        guard let userID = currentUserID, let currentUserEmail = Auth.auth().currentUser?.email else {
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

            // Add friend to user
            UserDB.shared.addFriendToUser(userID: userID, friendFirstName: userinfo.firstName ?? "Unknown")
            
            //add current user's first name to the friend's friendlist
            UserDB.shared.addFriendToUser(userID: userinfo.userID, friendFirstName: currentUserFirstName ?? "Unknown")


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

    
    func removeFriend(friendFirstName: String) {
        guard let currentUserID = currentUserID, let currentUserFirstName = self.currentUserFirstName else {
            print("User ID or first name not found")
            return
        }

        // Remove the friend from the current user's friend list
        let currentUserRef = Firestore.firestore().collection("BeFreeUsers").document(currentUserID)
        currentUserRef.updateData([
            "friends": FieldValue.arrayRemove([friendFirstName])
        ]) { [weak self] error in
            if let error = error {
                print("Error removing friend from current user: \(error)")
            } else {
                DispatchQueue.main.async {
                    self?.friends.removeAll { $0.firstName == friendFirstName }
                }
                print("Friend removed from current user's list")
            }
        }

        // Remove the current user from the friend's friend list
        UserDB.shared.fetchUserByFirstName(firstName: friendFirstName) { [weak self] friendInfo in
                guard let self = self, let friendInfo = friendInfo else {
                    print("Could not find friend's user info for first name: \(friendFirstName)")
                    return
                }
                let friendUserID = friendInfo.userID
            let friendUserRef = Firestore.firestore().collection("BeFreeUsers").document(friendUserID)
            friendUserRef.updateData([
                "friends": FieldValue.arrayRemove([currentUserFirstName])
            ]) { error in
                if let error = error {
                    print("Error removing current user from friend's list: \(error)")
                } else {
                    print("Current user's first name removed from friend's list")
                }
            }
        }
    }
    
//    func fetchFriendsScreenTime() {
//        guard let currentUserID = Auth.auth().currentUser?.uid else { return }
//
//        UserDB.shared.getUser(userid: currentUserID) { [weak self] userinfo in
//            guard let self = self, let userinfo = userinfo, let friendsList = userinfo.friends else { return }
//
//            for friendFirstName in friendsList {
//                self.fetchFriendScreenTimeByFirstName(friendFirstName)
//            }
//        }
//    }
//
//    private func fetchFriendScreenTimeByFirstName(_ firstName: String) {
//        UserDB.shared.fetchUserByFirstName(firstName: firstName) { [weak self] friendInfo in
//            guard let self = self, let friendInfo = friendInfo else { return }
//
//            let friendEmail = friendInfo.email
//            let screenTime = (hours: friendInfo.userScreenTime?.hours ?? 0, minutes: friendInfo.userScreenTime?.minutes ?? 0)
//            let friend = Friend(id: UUID(), email: friendEmail, firstName: firstName, userScreenTime: screenTime)
//
//            DispatchQueue.main.async {
//                self.friends.append(friend)
//            }
//        }
//    }

    func fetchFriendsScreenTime() {
        guard let currentUserID = Auth.auth().currentUser?.uid else { return }

        UserDB.shared.getUser(userid: currentUserID) { [weak self] userinfo in
            guard let self = self, let userinfo = userinfo, let friendsList = userinfo.friends else { return }

            for friendFirstName in friendsList {
                self.fetchFriendScreenTimeAndGoalByFirstName(friendFirstName)
            }
        }
    }

    private func fetchFriendScreenTimeAndGoalByFirstName(_ firstName: String) {
        UserDB.shared.fetchUserByFirstName(firstName: firstName) { [weak self] friendInfo in
            guard let self = self, let friendInfo = friendInfo else { return }

            let friendEmail = friendInfo.email
            let screenTime = (hours: friendInfo.userScreenTime?.hours ?? 0, minutes: friendInfo.userScreenTime?.minutes ?? 0)
            let screenTimeGoal = friendInfo.screenTimeGoal // Fetch the screen time goal
            let friend = Friend(id: UUID(), email: friendEmail, firstName: firstName, screenTimeGoal: screenTimeGoal, userScreenTime: screenTime)
            
            DispatchQueue.main.async {
                self.friends.append(friend)
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
                .padding(EdgeInsets(top: 48, leading: 16, bottom: 0, trailing: 16))

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
            
            
            if let firstName = viewModel.currentUserFirstName {
                if viewModel.friends.isEmpty {
                    Text("Time to make new friends!")
                        .font(.title2)
                        .padding([.top, .bottom])
                } else {
                    Text("Dear \(firstName), here is your list of friends:")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                }
            }

            List(viewModel.friends, id: \.id) { friend in
                HStack {
                    Text("Name: \(friend.firstName)")
                    Spacer()
                    Button(action: {
                        viewModel.removeFriend(friendFirstName: friend.firstName)
                    }) {
                        Image(systemName: "minus.circle")
                            .foregroundColor(.red)
                    }
                }
            }
            .listStyle(PlainListStyle())
//            .background(colorScheme == .dark ? .black : .white)
            
            Spacer()

            Button("Done adding friends") {
                dismiss()
            }
            .padding()
        }
//        .background(colorScheme == .dark ? .black : .white)
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
