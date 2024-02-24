//
//  DevicesBeReportingExtension.swift
//  BeeFree
//
//  Created by Anushka Vijay on 2/24/24.
//

import SwiftUI
import DeviceActivity


struct DevicesBeReportingExtension: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
            // Create a report for each DeviceActivityReport.Context that your app supports.
            TotalActivityReport { totalActivity in
                TotalActivityView(totalActivity: totalActivity)
            }
            // Add more reports here...
        }
}

//#Preview {
//    DevicesBeReportingExtension()
//}
