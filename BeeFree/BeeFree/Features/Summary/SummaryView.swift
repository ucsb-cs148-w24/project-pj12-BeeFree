
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
                of: .day, for: .now
            )!
        ),
        users: .all,
        devices: .init([.iPhone, .iPad]))
//        applications: Set<ApplicationToken>(),
//        categories: Set<ActivityCategoryToken>(),
//        webDomains: Set<WebDomainToken>()
    
    @State private var context: DeviceActivityReport.Context = .init(rawValue: "Total Activity")
    @State private var reportData: DeviceActivityReport? = nil
    
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
        
//        filter.applications = model.selectionToDiscourage.applicationTokens
//        filter.categories = model.selectionToDiscourage.categoryTokens
//        filter.webDomains = model.selectionToDiscourage.webDomainTokens
        ZStack{
            DeviceActivityReport(context, filter:filter)
            
//            Picker(selection: $context, label: Text("Context: ")) {
////                           Text("Bar Graph")
////                               .tag(DeviceActivityReport.Context.barGraph)
//                           Text("Pie Chart")
//                                .tag(DeviceActivityReport.Context.pieChart)
//            }
            
        }
//        .onAppear {
//            BeeFreeMonitor.applyFilter(&filter, from:model)
//        }
        //Text("hello world")
    }
}
