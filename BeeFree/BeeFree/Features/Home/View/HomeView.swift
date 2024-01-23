//
//  HomeView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.
//

import SwiftUI

struct HomeView: View {
    @Binding var isDarkMode : Bool
    @State private var apps = ["Instagram", "Reddit", "Youtube", "TikTok"]
    var body: some View {
        VStack(spacing: 0) {
            ForEach($apps, id: \.self) { $app in
                AppLimitDisplay(isDarkMode: $isDarkMode, appName: app)
            }
        }
        .padding()
    }
}
