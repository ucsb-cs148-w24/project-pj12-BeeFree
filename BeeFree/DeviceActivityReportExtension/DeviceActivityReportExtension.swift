//
//  DeviceActivityReportExtension.swift
//  DeviceActivityReportExtension
//
//  Created by Anushka Vijay on 2/12/24.
//

import DeviceActivity
import SwiftUI

@main
struct DeviceActivityReport: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        // Create a report for each DeviceActivityReport.Context that your app supports.
        TotalActivityReport { totalActivity in
            TotalActivityView(totalActivity: totalActivity)
        }
        // Add more reports here...
    }
}
