//
//  AppLimitDisplay.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/22/24.
//

import SwiftUI

struct AppLimitDisplay: View {
    @Binding var isDarkMode : Bool
    @State var appName : String
    var body: some View {
        RectangleSection(isDarkMode: $isDarkMode, height: 81)
    }
}

#Preview {
    AppLimitDisplay(isDarkMode: .constant(false), appName: "Bee Free")
}
