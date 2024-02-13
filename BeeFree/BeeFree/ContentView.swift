//
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
//    @Environment(\.colorScheme) var colorScheme
    @State var selectedTab: Tab = .home
    @State var isDarkMode = false
    @State var isPresented = false
    @State private var barHidden = true
    
    @StateObject var store : ManagedSettingsStore = ManagedSettingsStore()
    @StateObject var model : BeeFreeModel = BeeFreeModel.shared

    var body: some View {
        VStack {
            ZStack {
                NavigationView {
                    GeometryReader { proxy in
                        ScrollView {
                            ZStack{
                                //PollenAnimation(isDarkMode: $isDarkMode)
                                VStack {
                                    // Top bar
                                    TitleBarModifier(selectedTab: $selectedTab,
                                                     isDarkMode: $isDarkMode)
                                    .environmentObject(model)
                                    .environmentObject(store)

                                    // Main Page Content
                                    if (selectedTab == .home) {
                                        HomeView(isDarkMode: $isDarkMode,
                                                 set: $model.setOfApps)
                                            .environmentObject(model)
                                            .environmentObject(store)
                                    }
                                    else if (selectedTab == .summary) {
                                        //NavigationLink(ExampleView())
                                        ZStack {
                                            SummaryView(isDarkMode: $isDarkMode,
                                                        selectedTimePeriod: 0)
                                            .environmentObject(model)
                                            .environmentObject(store)
                                                .overlay(Text("Summary coming soon!")
                                                    .frame(maxWidth: .infinity,
                                                           minHeight:
                                                            proxy.size.height-128)
                                                    .foregroundColor(Color("DynamicGray"))
                                                    .background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                                    .fill(.ultraThinMaterial)
                                                    .offset(y: 32)))
                                        }
                                    }
                                    else if (selectedTab == .sharing) {
                                        ZStack{
                                            SharingView()
                                                .environmentObject(model)
                                                .environmentObject(store)
                                                .overlay(Text("Sharing coming soon!")
                                                    .offset(y: 262.4)
                                                    .frame(maxWidth: .infinity,
                                                       minHeight:
                                                        proxy.size.height-128)
                                                    .foregroundColor(Color("DynamicGray"))
                                                    .background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                                    .fill(.ultraThinMaterial)
                                                    .offset(y: 294.2)))
                                        }
                                    }
                                }
                                .background(GeometryReader {
                                    Color.clear.preference(key: ViewOffsetKey.self,
                                                           value: -$0.frame(in: .named("scroll")).origin.y)})
                                .onPreferenceChange(ViewOffsetKey.self) {
                                    if (!barHidden && $0 < 50) {
                                        barHidden = true
                                    } else if (barHidden && $0 > 50) {
                                        barHidden = false
                                    }
                                }
                            }
                        }
                        .scrollDisabled(selectedTab == .home ? false : true)
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
        .environmentObject(ManagedSettingsStore())
        .environmentObject(BeeFreeModel.shared)
}
