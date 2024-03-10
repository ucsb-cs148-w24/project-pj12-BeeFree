//
//  DevicesBeReporting.swift
//  DevicesBeReporting
//
//  Created by Anushka Vijay on 2/17/24.
//


import SwiftUI
import DeviceActivity
import ManagedSettings

@main
struct DevicesBeReporting: DeviceActivityReportExtension {
    
    var body: some DeviceActivityReportScene {
        TopAppsReport { topApps in
            TopThreeView(topThreeReport: topApps)
        }
    }
}
