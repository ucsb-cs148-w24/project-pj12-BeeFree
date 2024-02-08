//
//  SummaryView.swift
//  BeeFree
//
//  Created by Anushka Vijay and Kaveri Iyer on 1/23/24.
//

import SwiftUI

struct SummaryView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var isDarkMode : Bool
    @State var selectedTab: Tab = .summary
    @State private var barHidden = true
    
    var body: some View {
        VStack{
            ZStack{
                NavigationStack {
                    ScrollView {
                        ZStack {
                            //Top bar
                            PollenAnimation(isDarkMode: $isDarkMode)
                                VStack {
                                    TitleBarModifier(selectedTab: .constant(.summary), isDarkMode: $isDarkMode)
                                    ScreenTimeGoalView(isDarkMode: $isDarkMode)
                                    AppScreenTimeView(isDarkMode: $isDarkMode)
                                    Spacer()
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
                        ).edgesIgnoringSafeArea(.all))
                        .coordinateSpace(name: "scroll")
                        .navigationBarTitle("summary", displayMode: .inline)
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
                
}

#Preview {
    SummaryView(isDarkMode: .constant(false))
}
