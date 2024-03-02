
//  SummaryView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.


import SwiftUI
import DeviceActivity
import ManagedSettings
import FamilyControls

struct SummaryView: View {
    @Binding var isDarkMode : Bool
    @Binding var selectedApps: Set<ApplicationToken>
//    @State var selectedTimePeriod = 0
    
    @EnvironmentObject var store: ManagedSettingsStore
    @EnvironmentObject var model: BeeFreeModel
    
    @State private var context1: DeviceActivityReport.Context = .init(rawValue: "Total Activity")
    @State private var context2: DeviceActivityReport.Context = .init(rawValue: "Top Apps")
    @State private var reportData: DeviceActivityReport? = nil

    @State var filter = DeviceActivityFilter.init(
        segment: .daily(
            during: Calendar.current.dateInterval(
                of: .day, for: .now
            )!
        ),
        users: .all,
        devices: .init([.iPhone, .iPad]))
    
    var body: some View {
        ZStack{
            VStack{
                //ScreenTimeGoalView(isDarkMode: $isDarkMode)
                AppScreenTimeView(isDarkMode: $isDarkMode)
                    .environmentObject(store)
                    .environmentObject(model)
                Spacer()
            }
        }
    }
}
