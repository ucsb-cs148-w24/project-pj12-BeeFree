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
        ZStack {
            RectangleSection(isDarkMode: $isDarkMode, height: 200)
            VStack {
//                Text("Today's Screen Time")
                HStack {
                    Spacer()
                    CircleProgressBar(progress: 0.33, size: 125)
                }
                .padding([.leading, .trailing], 50)
            }
        }
    }
}

#Preview {
    ScreenTimeGoalView(isDarkMode: .constant(false))
}
