//
//  FriendView.swift
//  BeeFree
//
//  Created by Saeri on 3/8/24.
//

import Foundation
//import SwiftUI
//
//struct FriendView: View {
//    @Environment(\.colorScheme) var colorScheme
//    @Environment(\.dismiss) var dismiss
//    @Binding var isDarkMode: Bool
//    @ObservedObject var viewModel: FriendsViewModel
//
//    var body: some View {
//        VStack {
//            if viewModel.friends.isEmpty {
//                Text("You have no friends added yet.")
//                    .padding()
//                    .background(colorScheme == .dark ? Color("DarkerSky") : Color("LighterSky"))
//                    .foregroundColor(.black)
//                    .cornerRadius(8) // Adds rounded corners to the background
//                    .padding() // Adds padding around the background
//            } else {
//                List(viewModel.friends) { friend in
//                    HStack {
//                        Text("Name: \(friend.firstName)")
//                        Spacer()
//                    }
//                }
//                .listStyle(PlainListStyle())
//            }
//        }
//        .onAppear {
//            viewModel.fetchCurrentUserFriends()
//        }
//        // .background(colorScheme == .dark ? Color("DarkerSky") : Color("LighterSky"))
//        .navigationBarTitle("My Friends", displayMode: .large)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button("Dismiss") {
//                    dismiss()
//                }
//            }
//        }
//    }
//}
//
//struct FriendView_Previews: PreviewProvider {
//    static var previews: some View {
//        FriendView(isDarkMode: .constant(true), viewModel: FriendsViewModel())
//    }
//}

import SwiftUI

struct FriendView: View {
    // Example friend data
    let friendsScreenTime = [
        "Alex": "4 hours, 30 minutes",
        "Jordan": "5 hours, 15 minutes",
        "Sam": "3 hours, 45 minutes"
    ]
    
    var body: some View {
        List(friendsScreenTime.sorted(by: >), id: \.key) { name, time in
            HStack {
                Text(name)
                Spacer()
                Text(time)
            }
        }
        .navigationBarTitle("Friends' Screen Time", displayMode: .inline)
    }
}

struct FriendView_Previews: PreviewProvider {
    static var previews: some View {
        FriendView()
    }
}
