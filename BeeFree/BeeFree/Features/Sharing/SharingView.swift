//
//  SharingView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.
//

import SwiftUI
import FirebaseAuth

struct SharingView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    // Properties to hold the selected hours and minutes
    @State private var selectedHours = 0
    @State private var selectedMinutes = 0
    @State private var navigateToFriends = false
    @Binding var isDarkMode : Bool
    
    @State private var isExcusePresented = false
    
    var currentUserID: String? {
        Auth.auth().currentUser?.uid
    }

    
    // Define the ranges for hours and minutes
    let hours = Array(0...23)
    let minutes = Array(0...59)
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Sky")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    RectangleSection(height: 336)
                        .padding(EdgeInsets(top: 90, leading: 16, bottom: 16, trailing: 16))
                    Spacer()
                }

                VStack {
                    Text("Share your screen time today with your friends to view their reports!")
                        .bold()
                        .multilineTextAlignment(.leading)
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 16, leading: 16, bottom: 32, trailing: 16))
                    HStack {
                        Spacer()
                        // Hours picker
                        Picker("Hours", selection: $selectedHours) {
                            ForEach(hours, id: \.self) { hour in
                                Text("\(hour)").tag(hour)
                                    .foregroundColor(.white)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .environment(\.colorScheme, .dark)
//                        .clipped()

                        Text("hr")
                            .foregroundColor(.white)
                        
                        Picker("Minutes", selection: $selectedMinutes) {
                            ForEach(minutes, id: \.self) { minute in
                                Text("\(minute)").tag(minute)
                                    .foregroundColor(.white)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .environment(\.colorScheme, .dark)
//                        .clipped()

                        Text("min")
                        .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 0, leading: 32, bottom: 16, trailing: 32))
                    .foregroundColor(.white)

                    Button(action: {
                        if let userID = currentUserID {
                            UserDB.shared.updateUserScreenTime(userID: userID, hours: selectedHours, minutes: selectedMinutes)
                            self.navigateToFriends = true
                        }
                    }) {
                        Rectangle()
                            .fill(Color(.secondarySystemBackground))
                            .opacity(0.5)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .cornerRadius(10)
                            .overlay(
                            HStack {
                                Spacer()
                                Text("Share and View Friend's Activity")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                Spacer()
                            }, alignment: .center )
                        .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                    }
                    
                    Text("Only your reported time will be shared with users in your friends list. No other data will be shared.")
                        .font(.footnote)
                        .foregroundColor(Color("DynamicGray"))
                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 16))
                    
                    Spacer()
                    
                    Button(action: {self.isExcusePresented.toggle()}) {
                        Rectangle()
                            .fill(Color("LighterSky"))
                            .opacity(0.0)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .cornerRadius(10.0)
                            .overlay(
                                HStack {
                                    Image(systemName: "questionmark.circle")
                                        .foregroundColor(Color("DynamicYellow"))
                                    Text("Why do I need to report my own screen time?")
                                        .foregroundColor(Color("DynamicYellow"))
                                        .font(.subheadline)
                                        .bold()
                                }
                            , alignment: .center)
                            .padding(EdgeInsets(top: 16, leading: 16, bottom: 80, trailing: 16))
                    }
                    .sheet(isPresented: $isExcusePresented) {
                        // Create a sheet view to create a limit
                        ExcuseSheetView()
                    }
                }
            }
            .background(NavigationLink(destination: FriendView(), isActive: $navigateToFriends) { EmptyView() })
        }.navigationBarBackButtonHidden(true)
    }
}
