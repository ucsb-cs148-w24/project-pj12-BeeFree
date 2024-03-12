//
//  SharingView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.
//

import SwiftUI

struct SharingView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    // Properties to hold the selected hours and minutes
    @State private var selectedHours = 0
    @State private var selectedMinutes = 0
    @State private var navigateToFriends = false
    @Binding var isDarkMode : Bool
    
    
    // Define the ranges for hours and minutes
    let hours = Array(0...23)
    let minutes = Array(0...59)
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Section(header: Text("Enter your screen time today")
                                .foregroundColor(.white)) {
                        HStack(alignment: .center, spacing: 20) {
                            // Hours picker
                            Picker("Hours", selection: $selectedHours) {
                                ForEach(hours, id: \.self) { hour in
                                    Text("\(hour)").tag(hour)
                                        .foregroundColor(.white)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 100, alignment: .center)
                            .clipped()

                            Text("hr")
                                .foregroundColor(.white)
                            Picker("Minutes", selection: $selectedMinutes) {
                                ForEach(minutes, id: \.self) { minute in
                                    Text("\(minute)").tag(minute)
                                        .foregroundColor(.white)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 100, alignment: .center)
                            .clipped()

                            Text("min")
                                .foregroundColor(.white)
                        }
                        .foregroundColor(.white)
                    }
                    .padding(.vertical, 10)
                    Section {
                        HStack {
                            Text("Total Screen Time: ")
                                .foregroundColor(.white)
                            Spacer()
                            Text("\(selectedHours) hours, \(selectedMinutes) minutes")
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.vertical, 10)
                    Section {
                        Button(action: {
                            self.navigateToFriends = true
                        }) {
                            HStack {
                                Spacer()
                                Text("Save and View Friends")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            .padding()
                            .background(Color.blue) // Use your app's theme color here
                            .cornerRadius(10)
                            .shadow(radius: 5) // Optional shadow for depth
                        }
//                        Button("Save and View Friends"){
//                            self.navigateToFriends = true
//                        }
//                        .foregroundColor(.white)
                    }
                    .padding(.vertical, 10)
                }
                .background(Color("Sky"))
            }
            .background(Color("Sky"))
            .navigationBarTitle("Screen Time Entry", displayMode: .inline)
            .background(NavigationLink(destination: FriendView(), isActive: $navigateToFriends) { EmptyView() })
        }
        .background(Color("Sky"))
    }
}
