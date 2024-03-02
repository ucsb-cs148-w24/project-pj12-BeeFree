
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
<<<<<<< HEAD
    //var summarySelectedApps: Set<ApplicationToken>
    @State var selectedTimePeriod = 0
=======
    @Binding var selectedApps: Set<ApplicationToken>
//    @State var selectedTimePeriod = 0
>>>>>>> 6d2671a (IT WORKSgit add .)
    
    @EnvironmentObject var store: ManagedSettingsStore
    @EnvironmentObject var model: BeeFreeModel
    
<<<<<<< HEAD
=======
    @State private var context1: DeviceActivityReport.Context = .init(rawValue: "Total Activity")
    @State private var context2: DeviceActivityReport.Context = .init(rawValue: "Top Apps")
    @State private var reportData: DeviceActivityReport? = nil

>>>>>>> 6d2671a (IT WORKSgit add .)
    @State var filter = DeviceActivityFilter.init(
        segment: .daily(
            during: Calendar.current.dateInterval(
                of: .day, for: .now
            )!
        ),
        users: .all,
        devices: .init([.iPhone, .iPad]))
<<<<<<< HEAD
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
<<<<<<< HEAD
//        .onAppear {
//            BeeFreeMonitor.applyFilter(&filter, from:model)
//        }
=======
        .onAppear {
            filter.applications = model.selectionToDiscourage.applicationTokens
            filter.categories = model.selectionToDiscourage.categoryTokens
            filter.webDomains = model.selectionToDiscourage.webDomainTokens
            BeeFreeMonitor.applyFilter(&filter, from:model)
        }
>>>>>>> 6550f37 (SHOWING SCREENTIME NUMBER!!!!!")
        //Text("hello world")
=======
    
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
>>>>>>> 6d2671a (IT WORKSgit add .)
    }
}
