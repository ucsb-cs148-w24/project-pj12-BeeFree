//
//  UserDB.swift
//  BeeFree
//
//  Created by Hongye Liang on 1/25/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseCore

// Userinfo struct
struct Userinfo {
    let userID: String
    let email: String
    let displayName: String
    let firstName: String?
    var friends: [String]? // New field for friends
}

// UserDB class
final class UserDB {
    
    static let shared = UserDB()

    private init() { }

    // Method to create a new user with the friends field
    func createNewUser(auth: AuthDataResultModel, firstName: String) async throws {
        let userData: [String: Any] = [
            "userID" : auth.uid,
            "email" : auth.email ?? "",
            "firstName" : firstName,
            "friends" : [] // Initialize friends as an empty array
        ]
        
        try await Firestore.firestore().collection("BeFreeUsers").document(auth.uid).setData(userData, merge: false)
    }

    // Method to fetch a user, including the friends field
    func getUser(userid: String) async throws -> Userinfo {
        let temp = try await Firestore.firestore().collection("BeFreeUsers").document(userid).getDocument()
        
        guard let data = temp.data() else {
            throw URLError(.badServerResponse)
        }
        
        guard let userID = data["userID"] as? String,
              let email = data["email"] as? String,
              let displayName = data["firstName"] as? String else {
            throw URLError(.badServerResponse)
        }

        let firstName = data["firstName"] as? String
        let friends = data["friends"] as? [String] ?? [] // Fetch friends array
        
        return Userinfo(userID: userID, email: email, displayName: displayName, firstName: firstName, friends: friends)
    }

    // Method to check if a user exists
    func checkExistUser(uid: String) async throws -> Bool {
        let doc = Firestore.firestore().collection("BeFreeUsers").document(uid)
        let snapshot = try await doc.getDocument()
        return snapshot.exists
    }

    // Method to fetch all users
    func fetchUsers(completion: @escaping ([Userinfo]) -> Void) {
        var users: [Userinfo] = []
        let db = Firestore.firestore()
        let collection = db.collection("BeFreeUsers")

        collection.getDocuments { snapshot, error in
            guard let snapshot = snapshot, error == nil else {
                print(error?.localizedDescription ?? "Unknown error")
                completion([])
                return
            }

            for document in snapshot.documents {
                let data = document.data()
                if let user = self.parseUser(data: data) {
                    users.append(user)
                }
            }
            completion(users)
        }
    }

    // Helper method to parse user data
    private func parseUser(data: [String: Any]) -> Userinfo? {
        guard let userID = data["userID"] as? String,
              let email = data["email"] as? String,
              let displayName = data["firstName"] as? String else {
            return nil
        }

        let firstName = data["firstName"] as? String
        let friends = data["friends"] as? [String] ?? []
        return Userinfo(userID: userID, email: email, displayName: displayName, firstName: firstName, friends: friends)
    }

    // Method to fetch a user by their email
    func fetchUserByEmail(email: String, completion: @escaping (String?) -> Void) {
        let db = Firestore.firestore()
        let collection = db.collection("BeFreeUsers")

        collection.whereField("email", isEqualTo: email).getDocuments { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
                completion(nil)
            } else if let document = snapshot?.documents.first,
                      let firstName = document.data()["firstName"] as? String {
                completion(firstName)
            } else {
                completion(nil)
            }
        }
    }

    // Method to add a friend to a user's friends list
    func addFriendToUser(userID: String, friendFirstName: String) {
        let db = Firestore.firestore()
        let userRef = db.collection("BeFreeUsers").document(userID)

        userRef.updateData([
            "friends": FieldValue.arrayUnion([friendFirstName])
        ]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated")
            }
        }
    }
}

/*
 @Published var users: [Userinfo] = []
 
 init() {
     fetchUsers()
 }
 
 func fetchUsers() {
     users.removeAll()
     let db = Firestore.firestore()
     let collect = db.collection("BeFreeUsers")
     collect.getDocuments(source: .default) { snapshot, error in
         guard error == nil else {
             print(error!.localizedDescription)
             return
         }
         
         if let snapshot = snapshot {
             for document in snapshot.documents {
                 let data = document.data()
                 let userID = data["userID"] as? String ?? ""
                 let email = data["email"] as? String ?? ""
                 let displayName = data["firstName"] as? String ?? ""
                 let firstName = data["firstName"] as? String ?? ""
                 let friends = data["friends"] as? [String] ?? [] // Fetch friends array
                 
                 let user = Userinfo(userID: userID, email: email, displayName: displayName, firstName: firstName, friends: friends)
                 self.users.append(user)
             }
         }
     }
 */
