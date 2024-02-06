//
//  device_monitor_api.swift
//  device monitor api
//
//  Created by Anushka Vijay on 1/27/24.
//

import DeviceActivity
import SwiftUI

@main
struct device_monitor_api: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        // Create a report for each DeviceActivityReport.Context that your app supports.
        TotalActivityReport { totalActivity in
            TotalActivityView(totalActivity: totalActivity)
        }
        // Add more reports here...
    }
}
