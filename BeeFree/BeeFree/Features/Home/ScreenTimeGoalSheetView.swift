//
//  ScreenTimeGoalSheetView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 3/4/24.
//

import SwiftUI
import ManagedSettings
import DeviceActivity
import FamilyControls

struct ScreenTimeGoalSheetView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var isDarkMode : Bool
    @EnvironmentObject var store: ManagedSettingsStore
    @EnvironmentObject var model: BeeFreeModel
    
    var body: some View {
        // Title Stack
        VStack{
            HStack {
                Spacer()
                Text("Cancel")
                    .onTapGesture {
                        dismiss()
                    }
                    .bold()
                    .font(.title3)
                    .foregroundColor(Color("AccentColor"))
                    .padding(EdgeInsets(top: 32, leading: 16, bottom: 8, trailing: 16))
            }
            VStack{
                Text("Your Screen Time Goal")
                    .font(.title)
                    .bold()
                Text("Set a screen time goal to Bee Free of your devices, each day.")
                Spacer()
            }
            HStack{
                Image("plus.circle.fill")
                    .foregroundColor(Color("AccentColor"))
                Text("69")
                    .font(.title)
                    .bold()
                Image("plus.circle.fill")
                    .foregroundColor(Color("AccentColor"))
            }
            Spacer()
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .background(Color("Background").edgesIgnoringSafeArea(.all))
    }
}
