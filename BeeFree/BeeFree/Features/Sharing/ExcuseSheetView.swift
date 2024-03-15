//
//  ExcuseSheetView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 3/15/24.
//

import SwiftUI

struct ExcuseSheetView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            Text("What is Apple's Screen Time API?")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.headline)
                .bold()
                .padding(EdgeInsets(top: 32, leading: 16, bottom: 0, trailing: 16))
            Text("The Screen Time API is a framework provided by Apple for developers to program applications that utilize screen time data collected by your device. It allows developers to monitor activity, block applications, and set family controls. In order to protect user privacy, all data managed by the Screen Time API is encrypted and only available to the user and, if permitted, members in the user's iCloud family. Neither us nor even Apple can access that data.")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 4, leading: 16, bottom: 0, trailing: 16))
            Text("Why does it present a problem?")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.headline)
                .bold()
                .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
            Text("Our goal with BeeFree was to provide a way to encourage and motivate users to manage their screen time by creating an app that shares screen time data with the user's friends. However, because Apple's Screen Time API is provided to developers as a black box (meaning we cannot see or modify its implementation - it works independently of the app), we simply have no way to allow the user to permit their data to be shared with members outside their iCloud family. This was a design choice made by Apple, and it's sadly something we cannot change. We understand this can be frustrating, and we have taken steps towards changing this for the future. In the meantime, users will have to simply follow an honor code.")
                .padding(EdgeInsets(top: 4, leading: 16, bottom: 0, trailing: 16))
            
            Spacer()
    
            Rectangle()
                .fill(Color("DynamicYellow"))
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .cornerRadius(10.0)
                .overlay(
                    Text("I understand")
                        .foregroundColor(Color(.systemBackground))
                        .font(.subheadline)
                        .bold()
                , alignment: .center)
                .padding(EdgeInsets(top: 16, leading: 16, bottom: 32, trailing: 16))
                .onTapGesture {
                    dismiss()
                }
        }
    }
}

#Preview {
    ExcuseSheetView()
}
