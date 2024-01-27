//
//  SummaryView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.
//

import SwiftUI

struct SummaryView: View {
    @Binding var isDarkMode : Bool
    @State var selectedTimePeriod = 0
    var body: some View {
        VStack {
            Picker("Time Period", selection: $selectedTimePeriod) {
                Text("Weekly").tag(selectedTimePeriod)
                Text("Daily").tag(selectedTimePeriod)
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            ScreenTimeGoalView(isDarkMode: $isDarkMode)
            AppScreenTimeView(isDarkMode: $isDarkMode)
            Spacer()
        }
        .pickerStyle(.segmented)
        .padding()
    }
}

#Preview {
    SummaryView(isDarkMode: .constant(false), selectedTimePeriod: 0)
}
