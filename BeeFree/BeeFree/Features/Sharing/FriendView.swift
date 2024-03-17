//
//  FriendView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.
//

import SwiftUI

struct FriendView: View {
    @StateObject var viewModel = FriendsViewModel()
    @State private var navigatetoSharing = false

    var body: some View {
        NavigationView {
            ZStack{
                VStack{
                    if (viewModel.friends.isEmpty) {
                        ZStack {
                            Color("Sky").edgesIgnoringSafeArea(.all)
                            HStack {
                                Text("It's lonely here. Tap")
                                    .foregroundColor(.white)
                                    .opacity(0.5)
                                Image(systemName: "person.2.badge.gearshape.fill")
                                    .resizable()
                                    .opacity(0.5)
                                    .foregroundColor(.white)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 32, height: 32)
                                Text("to add your friends!")
                                    .foregroundColor(.white)
                                    .opacity(0.5)
                            }
                        }
                    }
                    else {
                        List(viewModel.friends) { friend in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(friend.firstName)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                    if let screenTime = friend.userScreenTime {
                                        if (screenTime.hours != 0 || screenTime.minutes != 0) {
                                            Text("\(screenTime.hours) hours, \(screenTime.minutes) minutes")
                                                .font(.subheadline)
                                                .foregroundColor(Color("DynamicGray"))
                                        }
                                        else {
                                            Text("No screen time recorded")
                                                .font(.subheadline)
                                                .foregroundColor(Color("DynamicGray"))
                                        }
                                    } else {
                                        Text("No screen time recorded")
                                            .font(.subheadline)
                                            .foregroundColor(Color("DynamicGray"))
                                    }
                                }.background(.clear)
                                Spacer()
                                if let screenTime = friend.userScreenTime {
                                    let progress = friend.calculateProgress(goalHours: friend.screenTimeGoal ?? 4.0)
                                    CircleProgressBar(progress: progress, size: 50)
                                        .background(.clear)
                                        .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 10))
                                }
                            }
                            .listRowBackground(Color("LighterSky"))
                        }.scrollContentBackground(.hidden)/*.background(Color("Sky"))*/
                    }
                    Section {
                        Button(action: {
                            
                            self.navigatetoSharing = true
                            
                        }) {
                            Rectangle()
                                .fill(Color(.systemBackground))
                                .opacity(0.5)
                                .frame(maxWidth: .infinity)
                                .frame(height: 64)
                                .cornerRadius(10.0)
                                .overlay(HStack {
                                    Text("Update Your Screen Time")
                                        .foregroundColor(Color(.white))
                                        .font(.subheadline)
                                        .bold()
                                }, alignment: .center)
                                .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                        }
    //                        Button("Save and View Friends"){
    //                            self.navigateToFriends = true
    //                        }
    //                        .foregroundColor(.white)
                    }.background(Color("Sky"))
                    .padding(EdgeInsets(top: 16, leading: 0, bottom: 76, trailing: 0))
                }
            }.background(Color("Sky"))
      
            .onAppear {
                viewModel.fetchFriendsScreenTime()
            }
            .background(NavigationLink(destination: SharingView(isDarkMode: .constant(false)), isActive: $navigatetoSharing) { EmptyView() })
        }
        .navigationBarBackButtonHidden(true)
    }
}





struct FriendView_Previews: PreviewProvider {
    static var previews: some View {
        FriendView()
    }
}
