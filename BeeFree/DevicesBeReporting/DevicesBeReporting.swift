//
//  DevicesBeReporting.swift
//  DevicesBeReporting
//
//  Created by Anushka Vijay on 2/17/24.
//

import DeviceActivity
import SwiftUI

@main
struct DevicesBeReporting: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        // Create a report for each DeviceActivityReport.Context that your app supports.
        TotalActivityReport { totalActivity in
            TotalActivityView(totalActivity: totalActivity)
        }
        TopAppsReport { topApps in
            TopThreeView(topThreeReport: topApps)
        }
        // Add more reports here...
    }
}
