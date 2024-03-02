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
    @Binding var set: [String]
    @EnvironmentObject var store: ManagedSettingsStore
    @EnvironmentObject var model: BeeFreeModel
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach($set, id: \.self) {$appn in
                AppLimitDisplay(isDarkMode: $isDarkMode, appName: appn)
            }
        }
        .padding()
    }
}
