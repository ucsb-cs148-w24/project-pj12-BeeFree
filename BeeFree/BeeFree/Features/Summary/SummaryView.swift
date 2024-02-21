
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
    //var summarySelectedApps: Set<ApplicationToken>
    @State var selectedTimePeriod = 0
    
    @EnvironmentObject var store: ManagedSettingsStore
    @EnvironmentObject var model: BeeFreeModel
    
    @State var filter = DeviceActivityFilter.init(
        segment: .daily(
            during: Calendar.current.dateInterval(
                of: .weekOfYear, for: .now
            )!
        ),
        users: .all,
        devices: .init([.iPhone, .iPad]),
        applications: Set<ApplicationToken>(),
        categories: Set<ActivityCategoryToken>(),
        webDomains: Set<WebDomainToken>()
    )
    @State private var context: DeviceActivityReport.Context = .init(rawValue: "pieChart")
    
    
    var body: some View {
        
//            Picker("Time Period", selection: $selectedTimePeriod) {
//                Text("Weekly").tag(selectedTimePeriod)
//                Text("Daily").tag(selectedTimePeriod)
//            }
//            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
//            ScreenTimeGoalView(isDarkMode: $isDarkMode)
//            AppScreenTimeView(isDarkMode: $isDarkMode)
//            let applications = model.selectionToDiscourage.applicationTokens
//            let categories = model.selectionToDiscourage.categoryTokens
//            let webDomains = model.selectionToDiscourage.webDomainTokens
        Text("hello world")
        filter.applications = model.selectionToDiscourage.applicationTokens
        filter.categories = model.selectionToDiscourage.categoryTokens
        filter.webDomains = model.selectionToDiscourage.webDomainTokens
        
        
        
            
    }
}
