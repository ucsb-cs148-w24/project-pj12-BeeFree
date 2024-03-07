//
//  HomeView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.
//

import SwiftUI
import DeviceActivity
import ManagedSettings
import FamilyControls

struct HomeView: View {
    @Binding var isDarkMode : Bool
    @Binding var set: [String]
    @EnvironmentObject var store: ManagedSettingsStore
    @EnvironmentObject var model: BeeFreeModel
    
    @State private var isScreenTimeGoalPresented = false
    
    var body: some View {
        VStack{
            Spacer()
            Button(action: {self.isScreenTimeGoalPresented.toggle()}) {
                Rectangle()
                    .fill(Color("LighterSky"))
                    .frame(maxWidth: .infinity)
                    .frame(height: 64)
                    .cornerRadius(16.0)
                    .overlay(HStack {
                        Image(systemName: "hourglass")
                            .foregroundColor(Color("DynamicGray"))
                        Text("Change your screen time goal")
                            .foregroundColor(Color("DynamicGray"))
                            .font(.subheadline)
                            .bold()
                    }, alignment: .center)
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 76, trailing: 16))
            }
            .sheet(isPresented: $isScreenTimeGoalPresented) {
                // Create a sheet view to create a limit
                ScreenTimeGoalSheetView(isDarkMode: $isDarkMode)
                    .environmentObject(BeeFreeModel.shared)
                    .environmentObject(store)
            }
        }
    }
}
