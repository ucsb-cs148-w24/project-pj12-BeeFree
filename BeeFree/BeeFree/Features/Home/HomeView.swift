//
//  HomeView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.
//

import SwiftUI
import DeviceActivity
import ManagedSettings
import FamilyControls

struct HomeView: View {
    @Binding var isDarkMode : Bool
    @EnvironmentObject var store: ManagedSettingsStore
    @EnvironmentObject var model: BeeFreeModel
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(model.selectionToDiscourage.applications.sorted{$0.localizedDisplayName ?? "" < $1.localizedDisplayName ?? ""}, id: \.self) {appn in
                var appname = ""
                if (appn.bundleIdentifier != nil) {
                    appname += appn.bundleIdentifier
                }
                AppLimitDisplay(isDarkMode: $isDarkMode, appName: Label(appname))
            }
            Text("Hello, world! oox ")
        }
        .padding()
    }
}
