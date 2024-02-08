//
//  ScreenTimeGoalSelector.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/22/24.
//

import SwiftUI

struct ScreenTimeGoalSelector: View {
    @Binding var isDarkMode : Bool
    var body: some View {
        RectangleSection(isDarkMode: $isDarkMode, height: 200)
    }
}

#Preview {
    ScreenTimeGoalSelector(isDarkMode: .constant(false))
}
