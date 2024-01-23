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
    @State private var barHidden = true
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color("Sky"), Color("DarkerSky")],
                startPoint: .top,
                endPoint: .bottom
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
                            .blur(radius: run ? 5 : 3)
                    }
                }
            }
            .animation(Animation.easeInOut(duration: 6)
            .repeatForever(autoreverses: true), value: run) // animate one value
            .onAppear() {
                self.run = true
            }
            
            
            VStack {
                ZStack {
                    NavigationView {
                        ScrollView {
                            VStack {
                                // Top bar
                                TitleBarModifier(selectedTab: $selectedTab,
                                                 isDarkMode: $isDarkMode)
                                // Main Page Content
                                if (selectedTab == .home) {
                                    HomeView(isDarkMode: $isDarkMode)
                                }
                                else if (selectedTab == .summary) {
                                    SummaryView(isDarkMode: $isDarkMode)
                                }
                                else if (selectedTab == .sharing) {
                                    SharingView()
                                }
                            }
                            .background(GeometryReader {
                                Color.clear.preference(key: ViewOffsetKey.self,
                                                       value: -$0.frame(in: .named("scroll")).origin.y)
                                })
                                .onPreferenceChange(ViewOffsetKey.self) {
                                    if !barHidden && $0 < 50 {
                                        barHidden = true
                                        print("<< hiding")
                                    } else if barHidden && $0 > 50{
                                        barHidden = false
                                        print(">> showing")
                                    }
                                }
                        }
                        .background(Color("Sky"))
                        .coordinateSpace(name: "scroll")
                        .navigationBarTitle(
                            ( selectedTab == .home 
                            ? "Bee Free" :
                              ( selectedTab == .summary
                              ? "Summary" : "Sharing")), displayMode: .inline)
                        .navigationBarHidden(barHidden)
                        .toolbarBackground(.ultraThinMaterial)
                    }
                    .animation(.default, value: barHidden)
                    .edgesIgnoringSafeArea(.all)
                    // Tab Selector
                    TabBarModifier(selectedTab: $selectedTab)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
        }
        
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }

    func calculateRandom(in value: CGFloat) -> CGFloat {
        return CGFloat(Int.random(in: 10..<Int(value) - 10))
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

#Preview {
    ContentView()
}
