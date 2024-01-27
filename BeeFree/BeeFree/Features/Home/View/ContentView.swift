//
//  ContentView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var selectedTab: Tab = .home
    @State var isDarkMode = false
    @State var isPresented = false
    @State private var barHidden = true
    
    var body: some View {
        VStack {
            ZStack {
                NavigationView {
                    ScrollView {
                        ZStack{
                            PollenAnimation(isDarkMode: $isDarkMode)
                            VStack {
                                // Top bar
                                TitleBarModifier(selectedTab: $selectedTab,
                                                 isDarkMode: $isDarkMode)
                                // Main Page Content
                                if (selectedTab == .home) {
                                    HomeView(isDarkMode: $isDarkMode)
                                }
                                else if (selectedTab == .summary) {
                                    SummaryView(isDarkMode: $isDarkMode,
                                    selectedTimePeriod: 0)
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
                                if (!barHidden && $0 < 50) {
                                    barHidden = true
                                } else if (barHidden && $0 > 50) {
                                    barHidden = false
                                }
                            }
                        }
                    }
                    .background(LinearGradient(
                        colors: [Color("Sky"), Color("DarkerSky")],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .edgesIgnoringSafeArea(.all))
                    .coordinateSpace(name: "scroll")
                    .navigationBarTitle(
                        ( selectedTab == .home
                        ? "Home" :
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
        .preferredColorScheme(isDarkMode ? .dark : .light)
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
