//
//  ContentView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var run = false
    @State var selectedTab: Tab = .home
    @State var isDarkMode = false
    @State var isPresented = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color("Sky"), Color("Background")],
                startPoint: .top,
                endPoint: .center
            )
            .edgesIgnoringSafeArea(.all)

            
            // CREDIT: https://stackoverflow.com/questions/63636548/having-trouble-creating-a-star-animation-in-swiftui
            GeometryReader { gp in
                ForEach(0..<8) {_ in
                    ForEach(0..<5) { _ in
                        Circle().fill(isDarkMode ? .black : .white)
                            .frame(width: 3, height: 3)
                            .position(x: calculateRandom(in: gp.size.width),
                                      y: calculateRandom(in: gp.size.height))
                            .blur(radius: run ? 4 : 2)
                    }
                }
            }
            .animation(Animation.easeInOut(duration: 6)
            .repeatForever(autoreverses: true), value: run) // animate one value
            .onAppear() {
                self.run = true
            }
            
            
            // Top bar
            VStack {
                TitleBarModifier(selectedTab: $selectedTab,
                         isDarkMode: $isDarkMode)
                
                // Main Page Content
                if (selectedTab == .home) {
                    HomeView()
                }
                else if (selectedTab == .summary) {
                    SummaryView(isDarkMode: $isDarkMode)
                }
                else if (selectedTab == .sharing) {
                    SharingView()
                }
                // Tab Selector
                TabBarModifier(selectedTab: $selectedTab)
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }

    func calculateRandom(in value: CGFloat) -> CGFloat {
        return CGFloat(Int.random(in: 10..<Int(value) - 10))
    }
}

#Preview {
    ContentView()
}
