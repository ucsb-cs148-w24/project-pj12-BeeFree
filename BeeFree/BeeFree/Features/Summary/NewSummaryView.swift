//
//  NewSummaryView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 2/29/24.
//

import SwiftUI
import DeviceActivity
import ManagedSettings

struct NewSummaryView: View {
    @Binding var isDarkMode : Bool
    @Binding var selectedApps: Set<ApplicationToken>
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
        NavigationStack {
            VStack{
                DeviceActivityReport(context1, filter: filter)
                DeviceActivityReport(context2, filter: filter)
                Spacer()
            }
        }
        .onAppear(perform:{ BeeFreeMonitor.applyFilter(&filter, from: model) })
    }
}
