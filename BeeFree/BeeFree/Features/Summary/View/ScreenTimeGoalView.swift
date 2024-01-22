//
//  ScreenTimeGoalView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/22/24.
//

import SwiftUI

struct ScreenTimeGoalView: View {
    @Binding var isDarkMode : Bool
    var body: some View {
        ZStack{
            RectangleSection(isDarkMode: $isDarkMode)
            CircleProgressBar(progress: 0.33, size: 125)
        }
    }
}

#Preview {
    ScreenTimeGoalView(isDarkMode: .constant(false))
}
