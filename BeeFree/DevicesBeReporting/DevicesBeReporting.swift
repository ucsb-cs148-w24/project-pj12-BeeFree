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
        TopAppsReport { topApps in
            TopThreeView(topThreeReport: topApps)
        }
    }
}
