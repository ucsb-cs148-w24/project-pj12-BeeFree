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
//         NavigationView {
//         GeometryReader { proxy in
//         ScrollView {
//                PollenAnimation(isDarkMode: $isDarkMode)
                VStack {
                    // Top bar
                    TitleBarModifier(selectedTab: $selectedTab,
                                     isDarkMode: $isDarkMode)
                    .environmentObject(BeeFreeModel.shared)
                    .environmentObject(store)

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
                        SharingView(isDarkMode: $isDarkMode)
                            .opacity(selectedTab == .sharing ? 1.0 : 0.0)
                            .disabled(selectedTab == .sharing ? false : true)
//                            .environmentObject(model)
//                            .environmentObject(store)
//                            .overlay(Text("Sharing coming soon!")
//                                .offset(y: 262.4)
//                                .frame(maxWidth: .infinity,
//                                       minHeight:
//                                        proxy.size.height-128)
//                                    .foregroundColor(Color("DynamicGray"))
//                                    .background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
//                                        .fill(.ultraThinMaterial)
//                                        .offset(y: 294.2)))
                    }
                        
                }
            //              .background(GeometryReader {
//                                    Color.clear.preference(key: ViewOffsetKey.self,
//                                                           value: -$0.frame(in: .named("scroll")).origin.y)})
//                                .onPreferenceChange(ViewOffsetKey.self) {
//                                    if (!barHidden && $0 < 50) {
//                                        barHidden = true
//                                    } else if (barHidden && $0 > 50) {
//                                        barHidden = false
//                                    }
//                                }
//
                .background(Color("Sky"))
//          }
//                        .scrollDisabled(selectedTab == .sharing ? true : false)
//                    }
//                    .coordinateSpace(name: "scroll")
//                    .navigationBarTitle(
//                        ( selectedTab == .home
//                        ? "Home" :
//                          ( selectedTab == .summary
//                          ? "Summary" : "Sharing")), displayMode: .inline)
//                    .navigationBarHidden(barHidden)
//                    .toolbarBackground(.ultraThinMaterial)
//          }
//          .animation(.default, value: barHidden)
//                .edgesIgnoringSafeArea(.all)
            // Tab Selector
            TabBarModifier(selectedTab: $selectedTab)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
}

//struct ViewOffsetKey: PreferenceKey {
//    typealias Value = CGFloat
//    static var defaultValue = CGFloat.zero
//    static func reduce(value: inout Value, nextValue: () -> Value) {
//        value += nextValue()
//    }
//}
