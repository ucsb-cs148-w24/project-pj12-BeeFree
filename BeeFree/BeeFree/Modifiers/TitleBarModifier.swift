//
//  TitleBarModifier.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.
//

import SwiftUI
import FamilyControls
import ManagedSettings
import DeviceActivity
import FirebaseAuth

struct TitleBarModifier: View {
    @Environment(\.colorScheme) private var colorScheme
    @Binding var selectedTab: Tab
    @Binding var isDarkMode: Bool
    @State private var isCreateLimitPresented = false
    @State private var isAccountSettingsPresented = false
    @State private var isAddFriendPresented = false
    @State private var currentUserInfo: Userinfo?
    
    @EnvironmentObject var store: ManagedSettingsStore
    @EnvironmentObject var model: BeeFreeModel
    
    var body: some View {
        HStack {
            VStack {
                if(selectedTab == .home) {
                    Group {
                        Text("Bee ")
                            .foregroundColor(Color("DynamicYellow"))
                            .font(.largeTitle)
                            .bold() +
                        Text("Free")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .bold()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 32, leading: 16, bottom: 16, trailing: 16))
                }
                else if(selectedTab == .summary) {
                    Text(Date().formatted(.dateTime.weekday(.wide).month().day()))
                        .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                        .font(.footnote)
                        .bold()
                        .foregroundColor(Color("DynamicGray"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
                    Text("Summary")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                }
                else if(selectedTab == .sharing) {
                    Text(Date().formatted(.dateTime.weekday(.wide).month().day()))
                        .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                        .font(.footnote)
                        .bold()
                        .foregroundColor(Color("DynamicGray"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
                    Text("Sharing")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                }
                else {}
            }
            Spacer()
            HStack{
                if (selectedTab == .home) {
                    Button(action: {self.isCreateLimitPresented.toggle()}) {
                        Image(systemName: "plus")
                            .resizable()
                            .opacity(0.5)
                            .foregroundColor(.white)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 27, height: 27)
                            .padding(EdgeInsets(top: 32, leading: 16, bottom: 16, trailing: 0))
                    }
<<<<<<< HEAD
                    .sheet(isPresented: $isAddFriendPresented) {
                        AddFriendView(isDarkMode: $isDarkMode, viewModel: FriendsViewModel())
                            .environmentObject(model)
                            .environmentObject(store)
                        }
                    
                }

                else if (selectedTab == .sharing) {
                    Button(action: { self.isAddFriendPresented.toggle() }) {
                        Image(systemName: "person.2.badge.gearshape.fill")
                            .resizable()
                            .opacity(0.5)
                            .foregroundColor(.white)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 42, height: 42)
                            .padding(EdgeInsets(top: 32, leading: 16, bottom: 16, trailing: 0))
                    }
                    .sheet(isPresented: $isAddFriendPresented) {
                        // Initialize FriendsViewModel without DataManager
                        AddFriendView(isDarkMode: $isDarkMode, viewModel: FriendsViewModel())
=======
                    .sheet(isPresented: $isCreateLimitPresented) {
                        // Create a sheet view to create a limit
                        CreateLimitSheetView(isDarkMode: $isDarkMode, selectedApps: $model.selectionToDiscourage.applicationTokens)
>>>>>>> f4495ef (added device activity report extension and passed in relevant vars)
                            .environmentObject(model)
                            .environmentObject(store)
                    }
                }

                Button(action: {self.isAccountSettingsPresented.toggle()}) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .opacity(0.5)
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32, height: 32)
                        .padding(EdgeInsets(top: 32, leading: 16, bottom: 16, trailing: 16))
                }
                
                .onAppear {
                    getUserData()
                }
                
                .sheet(isPresented: $isAccountSettingsPresented) {
                    // Create a sheet view with profile details and settings
                    ProfileSheetView(isDarkMode: $isDarkMode, userInfo: $currentUserInfo) 
                }
            }
            
        }
        Spacer()
    }
    
    var currentUserID: String? {
        return Auth.auth().currentUser?.uid
    }

    func getUserData() {
        guard let userID = currentUserID else {
            print("No current user ID available")
            return
        }

        UserDB.shared.getUser(userid: userID) { userinfo in
            if let userinfo = userinfo {
                print("User data fetched: \(userinfo)")
                self.currentUserInfo = userinfo
            } else {
                print("Failed to fetch user info or user info not found")
            }
        }
    }
}

#Preview {
    TitleBarModifier(selectedTab: .constant(.sharing),
             isDarkMode: .constant(false))
}
