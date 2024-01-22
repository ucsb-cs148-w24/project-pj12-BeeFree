//
//  SummaryView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.
//

import SwiftUI

struct SummaryView: View {
    @Binding var isDarkMode : Bool
    var body: some View {
        VStack {
            ScreenTimeGoalView(isDarkMode: $isDarkMode)
            AppScreenTimeView(isDarkMode: $isDarkMode)
            Spacer()
        }
    }
}

#Preview {
    SummaryView(isDarkMode: .constant(false))
}
