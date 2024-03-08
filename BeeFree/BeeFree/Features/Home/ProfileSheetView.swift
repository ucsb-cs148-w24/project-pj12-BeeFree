//
//  ProfileSheetView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.
//

import SwiftUI
import DeviceActivity
import ManagedSettings
import FamilyControls

struct ProfileSheetView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @Binding var isDarkMode: Bool
    @Binding var userInfo: Userinfo? 
    @State var isScreenTimeGoalPresented: Bool = false
    @EnvironmentObject var store: ManagedSettingsStore
    @EnvironmentObject var model: BeeFreeModel
    

    var body: some View {
        NavigationStack {
            VStack {
                // Title Stack
                ZStack {
                    HStack {
                        Text("Account")
                            .bold()
                            .font(.title2)
                            .padding(EdgeInsets(top: 32, leading: 16, bottom: 8, trailing: 16))
                    }
                    HStack {
                        Text("Done")
                            .onTapGesture {
                                dismiss()
                            }
                            .bold()
                            .font(.title3)
                            .foregroundColor(Color("AccentColor"))
                            .padding(EdgeInsets(top: 32, leading: 16, bottom: 8, trailing: 16))
                        Spacer()
                    }
                }
                // Settings
                Form {
                    Section(content: {
                        HStack{
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .foregroundColor(Color("DynamicGray"))
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 48, height: 48)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
                            VStack{
                                Text(userInfo?.displayName ?? "Unknown name").font(.title3).frame(maxWidth: .infinity, alignment: .leading)
                                Text(userInfo?.email ?? "Unknown email").frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    })
                    Section(content: {
                        HStack{
                            Button(action: {self.isScreenTimeGoalPresented.toggle()}) {
                                Text("Change Screen Time Goal").font(.title3)
                            }
                            .sheet(isPresented: $isScreenTimeGoalPresented) {
                                // Create a sheet view to create a limit
                                ScreenTimeGoalSheetView(isDarkMode: $isDarkMode, goal: model.getScreenTimeGoal())
                                    .environmentObject(BeeFreeModel.shared)
                                    .environmentObject(store)
                            }
                        }
                    })
                    Section(content: {
                        HStack{
                            Text("Privacy").font(.title3)
                        }
                        HStack{
                            Text("Notifications").font(.title3)
                        }
                    })
                    Section(content: {
                        HStack{
                            Toggle(isOn: $isDarkMode) {
                                Text("Dark Mode").font(.title3)
                            }
                        }
                    })
                    Section(content: {
                        HStack{
                            Text("Sign Out")
                                .font(.title3)
                                .foregroundColor(.red)
                        }
                    })
                }
                Spacer()
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .edgesIgnoringSafeArea(.all)
    }
}

//#Preview {
//    ProfileSheetView(isDarkMode: .constant(false))
//}

struct ProfileSheetView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyUserInfo = Userinfo(userID: "123", email: "goodExample@example.com", displayName: "Big Boy", firstName: "Boy", friends: [])

        ProfileSheetView(isDarkMode: .constant(false), userInfo: .constant(dummyUserInfo))
            .previewLayout(.sizeThatFits)
    }
}
