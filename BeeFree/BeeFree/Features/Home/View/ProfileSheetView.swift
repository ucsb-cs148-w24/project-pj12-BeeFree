//
//  ProfileSheetView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.
//

import SwiftUI

struct ProfileSheetView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @Binding var isDarkMode: Bool

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
                        Spacer()
                        Text("Done")
                            .onTapGesture {
                                dismiss()
                            }
                            .bold()
                            .font(.title3)
                            .foregroundColor(.yellow)
                            .padding(EdgeInsets(top: 32, leading: 16, bottom: 8, trailing: 16))
                    }
                }
                // Settings
                Form {
                    Section(content: {
                        HStack{
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .foregroundColor(.gray)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 48, height: 48)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
                            VStack{
                                Text("Name").font(.title3).frame(maxWidth: .infinity, alignment: .leading)
                                Text("Email").frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    })
                    Section(content: {
                        HStack{
                            Text("Change Screen Time Goal").font(.title3)
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
    }
}

#Preview {
    ProfileSheetView(isDarkMode: .constant(false))
}
