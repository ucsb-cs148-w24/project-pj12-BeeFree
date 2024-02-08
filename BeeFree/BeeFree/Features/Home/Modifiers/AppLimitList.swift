//
//  AppLimitList.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/22/24.
//

import SwiftUI

struct AppLimitList: View {
    @Binding var isDarkMode : Bool
    @State private var apps = ["Instagram", "Reddit", "Youtube", "TikTok", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k"]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach($apps, id: \.self) { $app in
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color("LighterSky"))
                    .frame(height: 60)
                    .padding(5)
            }
        }
    }
}

#Preview {
    AppLimitList(isDarkMode: .constant(false))
}
