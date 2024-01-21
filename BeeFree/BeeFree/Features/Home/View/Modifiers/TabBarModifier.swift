//
//  TabBarModifier.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case home = "house"
    case summary = "chart.bar.doc.horizontal"
    case sharing = "person.2"
}

struct TabBarModifier: View {
    @Environment(\.colorScheme) private var colorScheme
    @Binding var selectedTab: Tab
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    
                    VStack {
                        Spacer()
                            .frame(height: 10)
                        Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                            .foregroundColor(selectedTab == tab ? Color("AccentColor") : Color("DynamicGray"))
                            .font(.system(size: 26))
                            .onTapGesture {
                                selectedTab = tab
                            }
                        if (tab == .home) {
                            Spacer()
                                .frame(height: 5)
                            Text("Home")
                                .bold()
                                .font(.system(size: 12))
                                .foregroundColor(selectedTab == tab ? Color("AccentColor") : Color("DynamicGray"))
                                .onTapGesture {
                                    selectedTab = tab
                                }
                        }
                        if (tab == .summary) {
                            Spacer()
                                .frame(height: 5)
                            Text("Summary")
                                .bold()
                                .font(.system(size: 12))
                                .foregroundColor(selectedTab == tab ? Color("AccentColor") : Color("DynamicGray"))
                                .onTapGesture {
                                    selectedTab = tab
                                }
                        }
                        if (tab == .sharing) {
                            Spacer()
                                .frame(height: 5)
                            Text("Sharing")
                                .bold()
                                .font(.system(size: 12))
                                .foregroundColor(selectedTab == tab ? Color("AccentColor") : Color("DynamicGray"))
                                .onTapGesture {
                                    selectedTab = tab
                                }
                        }
                        else {}
                    }
                    Spacer()
                }
            }
            .frame(width: nil, height: 60)
            .background(.ultraThinMaterial)
        }
    }
}

#Preview {
    TabBarModifier(selectedTab: .constant(.summary))
}

