//
//  CreateLimitSheetView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.
//

import SwiftUI
import DeviceActivity
import ManagedSettings
import FamilyControls
//extension DeviceActivityReport.Context {
//    // If your app initializes a DeviceActivityReport with this context, then the system will use
//    // your extension's corresponding DeviceActivityReportScene to render the contents of the
//    // report.
//    static let totalActivity = Self("Total Activity")
//    static let pieChart = Self("pieChart")
//}

struct CreateLimitSheetView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @Binding var isDarkMode: Bool
    @Binding var selectedApps: Set<ApplicationToken>
    @State private var hours: Int = 0
    @State private var minutes: Int = 0
    @State private var seconds: Int = 0
    @State private var savedTime: (hours: Int, minutes: Int, seconds: Int)?
    @State private var isDiscouragedPresented = false
    @State var selection = FamilyActivitySelection()

    @EnvironmentObject var store: ManagedSettingsStore
    @EnvironmentObject var model: BeeFreeModel
    
    var body: some View {
        NavigationStack {
            VStack {
                // Title Stack
                ZStack {
                    HStack {
                        Text("Create App Limit")
                            .bold()
                            .font(.title2)
                            .padding(EdgeInsets(top: 32, leading: 16, bottom: 8, trailing: 16))
                    }
                    HStack {
                        Spacer()
                        Text("Done")
                            .onTapGesture {
                                dismiss()
                            }
                            .bold()
                            .font(.title3)
                            .foregroundColor(Color("AccentColor"))
                            .padding(EdgeInsets(top: 32, leading: 16, bottom: 8, trailing: 16))
                    }
                    
                }
                // Settings
                Form {
                    Section(header: Text("Applications")) {
                        Button("Select Apps to Discourage") {
                            isDiscouragedPresented = true
                        }
                        .familyActivityPicker(isPresented: $isDiscouragedPresented, selection: $model.selectionToDiscourage)
                    }
//                    .onChange(of: model.selectionToDiscourage) {
//                        BeeFreeModel.shared.setShieldRestrictions()
//                        //var summaryApps = SummarySet
//                    }
                    Section(header: Text("Time Limit")) {
                        HStack{
                            Picker("Hours", selection: $hours) {
                                ForEach(0..<24, id: \.self) { hour in
                                    Text("\(hour) hr").tag(hour)
                                }
                            }
                            .pickerStyle(.wheel)
                            
                            Picker("Minutes", selection: $minutes) {
                                ForEach(0..<60, id: \.self) { minute in
                                    Text("\(minute) min").tag(minute)
                                }
                            }
                            .pickerStyle(.wheel)
                            
                            Picker("Seconds", selection: $seconds) {
                                ForEach(0..<60, id: \.self) { second in
                                    Text("\(second) sec").tag(second)
                                }
                            }
                            .pickerStyle(.wheel)
                        }
                        
                        Section {
                            Button("Save Time") {
                                let new_threshold = DateComponents(hour: savedTime?.hours,
                                                                   minute: savedTime?.minutes,
                                                                   second: savedTime?.seconds)
                                model.changeThreshold(threshold: new_threshold)
                                saveTime()
                                DeviceActivityReport(.init("Home Report"))
                                     .frame(maxWidth: .infinity)
                                     .environmentObject(store)
                                     .environmentObject(model)
                            }
                        }
                    }
                }
                DeviceActivityReport(.init("Home Report"))
                     .frame(maxWidth: .infinity)
                     .environmentObject(store)
                     .environmentObject(model)
                Spacer()
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
    private func saveTime() {
        savedTime = (hours, minutes, seconds)
        BeeFreeSchedule.setSchedule()
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(model.selectionToDiscourage) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "selection")
        }
    }
}
