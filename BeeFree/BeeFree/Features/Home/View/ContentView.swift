//
//  ContentView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var selectedTab: Tab = .home
    @State private var isDarkMode = false
    @State private var isPresented = false
    
    var body: some View {
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            // Top bar
            VStack {
                TitleBarModifier(selectedTab: $selectedTab,
                         isDarkMode: $isDarkMode)
            }
            
            // Main Page Content
            if (selectedTab == .home) {
                HomeView()
            }
            else if (selectedTab == .summary) {
                SummaryView()
            }
            else if (selectedTab == .sharing) {
                SharingView()
            }
            
            // Tab Selector
            TabBarModifier(selectedTab: $selectedTab)
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    ContentView()
}
