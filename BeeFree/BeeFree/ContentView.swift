//  ContentView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.
//

import SwiftUI
import DeviceActivity
import ManagedSettings
import FamilyControls

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var selectedTab: Tab = .home
    @State var isDarkMode : Bool
    @State var isPresented = false
    @State private var barHidden = true
    
    @StateObject var store : ManagedSettingsStore = ManagedSettingsStore()
    @StateObject var model : BeeFreeModel = BeeFreeModel.shared

    var body: some View {
        ZStack {
            Color("Sky")
            .edgesIgnoringSafeArea(.all)
            VStack {
                // PollenAnimation(isDarkMode: $isDarkMode)
                
                // Top bar
                TitleBarModifier(selectedTab: $selectedTab,
                                 isDarkMode: $isDarkMode)
                .environmentObject(BeeFreeModel.shared)
                .environmentObject(store)
                .frame(maxHeight: 80)
                .padding(EdgeInsets(top:0, leading:0, bottom: 16, trailing: 0))
                
                // Main Page Content
                ZStack {
                    HomeView(isDarkMode: $isDarkMode,
                             set: $model.setOfApps)
                    .environmentObject(model)
                    .environmentObject(store)
                    .opacity(selectedTab == .home ? 1.0 : 0.0)
                    .disabled(selectedTab == .home ? false : true)
                    SummaryView(isDarkMode: $isDarkMode, selectedApps: $model.selectionToDiscourage.applicationTokens)
                        .environmentObject(model)
                        .environmentObject(store)
                        .opacity(selectedTab == .summary ? 1.0 : 0.0)
                        .disabled(selectedTab == .sharing ? false : true)
//                        .frame(maxWidth: .infinity, maxHeight:.infinity)
                    SharingView(isDarkMode: $isDarkMode)
                        .opacity(selectedTab == .sharing ? 1.0 : 0.0)
                        .disabled(selectedTab == .sharing ? false : true)
                }
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
                
            // Tab Selector
            TabBarModifier(selectedTab: $selectedTab)
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
}
