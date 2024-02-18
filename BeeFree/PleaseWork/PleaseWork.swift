//
//  PleaseWork.swift
//  PleaseWork
//
//  Created by Karankumar Mageswaran on 2/17/24.
//

import DeviceActivity
import SwiftUI

@main
struct PleaseWork: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        // Create a report for each DeviceActivityReport.Context that your app supports.
        TotalActivityReport { totalActivity in
            TotalActivityView(totalActivity: totalActivity)
        }
        // Add more reports here...
    }
}
