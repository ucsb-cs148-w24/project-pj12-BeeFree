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
//        VStack(spacing: 0) {
//            ForEach($set, id: \.self) {$appn in
//                AppLimitDisplay(isDarkMode: $isDarkMode, appName: appn)
//            }
//        }
//        .padding()
        VStack {
            Button(action: {self.isScreenTimeGoalPresented.toggle()}) {
                ZStack {
                    Image(systemName: "plus")
                        .resizable()
                        .opacity(0.5)
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 27, height: 27)
                        .padding(EdgeInsets(top: 32, leading: 16, bottom: 16, trailing: 0))
                    Rectangle()
                        .fill(Color("AccentColor"))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .cornerRadius(16.0)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                }
            }
            .sheet(isPresented: $isScreenTimeGoalPresented) {
                // Create a sheet view to create a limit
                ScreenTimeGoalSheetView(isDarkMode: $isDarkMode)
                    .environmentObject(BeeFreeModel.shared)
                    .environmentObject(store)
            }
//            Rectangle()
//                .fill(Color("LighterSky"))
//                .background(.ultraThinMaterial)
//                .frame(maxWidth: .infinity)
//                .frame(height: height)
//                .cornerRadius(16.0)
//                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            Spacer()
        }
    }
}
