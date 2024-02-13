//
//  SummaryView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.
//

import SwiftUI
import DeviceActivity
import ManagedSettings
import FamilyControls

struct SummaryView: View {
    @Binding var isDarkMode : Bool
    //@Binding var selectedApps: Set<ApplicationToken>
    @State var selectedTimePeriod = 0
    
    @EnvironmentObject var store: ManagedSettingsStore
    @EnvironmentObject var model: BeeFreeModel
    
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
