//
//  HomeView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.
//

import SwiftUI

struct HomeView: View {
    @Binding var isDarkMode : Bool
    @State private var apps = ["Instagram", "Reddit", "Youtube", "TikTok", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k"]
    var body: some View {
        VStack(spacing: 0) {
            ForEach($apps, id: \.self) { $app in
                Rectangle()
                    .fill(Color("LighterSky"))
                    .background(.ultraThinMaterial)
                    .frame(height: 90)
                    .cornerRadius(16.0)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            }
        }
    }
}
