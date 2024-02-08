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


struct Userinfo{
    let userID: String
    let email: String
    let displayName: String
    let firstName: String?
}


final class UserDB{
    
    static let shared = UserDB()
    private init() { }
    
    func createNewUser(auth: AuthDataResultModel, firstName: String) async throws{
        var userData: [String: Any] = [
            "userID" : auth.uid,
            "email" : auth.email ?? "",
            "firstName" : firstName
        ]
        
        try await Firestore.firestore().collection("BeFreeUsers").document(auth.uid).setData(userData, merge: false)
    }
    
    func getUser(userid: String) async throws -> Userinfo {
        let temp = try await Firestore.firestore().collection("BeFreeUsers").document(userid).getDocument()
        
        guard let data = temp.data() else{
            throw URLError(.badServerResponse)
        }
        
        let userID = data["userID"] as? String ?? ""
        let email = data["email"] as! String
        let displayName = data["firstName"] as! String
        let firstName = data["firstName"] as? String
        
        return Userinfo(userID: userID, email: email, displayName: displayName, firstName: firstName)
    }
    
    func checkExistUser(uid: String) async throws -> Bool{
        let doc = Firestore.firestore().collection("BeFreeUsers").document(uid) // change BeFreeUsers to BeeFreeUsers to change old user's firstName
        let snapshot = try await doc.getDocument()
        return snapshot.exists
    }
    

}

// find all users
/*class DataManager: ObservableObject{
    @Published var users: [Userinfo] = []
    
    init(){
        fetchUsers()
    }
    
    func fetchUsers(){
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
                    
                    let user = Userinfo(userID: userID, email: email, displayName: displayName)
                        self.users.append(user)
                }
            }
        }
    }
}*/
