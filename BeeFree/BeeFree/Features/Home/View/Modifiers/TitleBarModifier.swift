//
//  TitleBarModifier.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.
//

import SwiftUI

struct TitleBarModifier: View {
    @Environment(\.colorScheme) private var colorScheme
    @Binding var selectedTab: Tab
    @Binding var isDarkMode: Bool
    @State private var isCreateLimitPresented = false
    @State private var isAccountSettingsPresented = false
    
    var body: some View {
        HStack {
            VStack {
                // Display title based on selected tab
                if(selectedTab == .home) {
                    Text("BeeFree")
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 32, leading: 16, bottom: 16, trailing: 16))
                        .overlay {
                            LinearGradient(
                                colors: [.green, .yellow],
                                startPoint: .leading,
                                endPoint: .center
                            )
                            .mask(
                                Text("BeeFree")
                                    .font(.largeTitle)
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(EdgeInsets(top: 32, leading: 16, bottom: 16, trailing: 16))
                            )
                        }
                }
                else if(selectedTab == .summary) {
                    Text(Date().formatted(.dateTime.weekday(.wide).month().day()))
                        .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
                    Text("Summary")
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                }
                else if(selectedTab == .sharing) {
                    Text(Date().formatted(.dateTime.weekday(.wide).month().day()))
                        .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
                    Text("Sharing")
                        .font(.largeTitle)
                        .bold()
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
                            .foregroundColor(.yellow)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 27, height: 27)
                            .padding(EdgeInsets(top: 32, leading: 16, bottom: 16, trailing: 0))
                    }
                    .sheet(isPresented: $isCreateLimitPresented) {
                        // Create a sheet view to create a limit
                        CreateLimitSheetView(isDarkMode: $isDarkMode)
                    }
                    
                }
                Button(action: {self.isAccountSettingsPresented.toggle()}) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .foregroundColor(.gray)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32, height: 32)
                        .padding(EdgeInsets(top: 32, leading: 16, bottom: 16, trailing: 16))
                }
                .sheet(isPresented: $isAccountSettingsPresented) {
                    // Create a sheet view with profile details and settings
                    ProfileSheetView(isDarkMode: $isDarkMode)
                }
            }
        }
        Spacer()
    }
}

#Preview {
    TitleBarModifier(selectedTab: .constant(.sharing),
             isDarkMode: .constant(false))
}
