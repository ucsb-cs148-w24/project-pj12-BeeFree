//
//  TotalActivityView.swift
//  DevicesBeReporting
//
//  Created by Anushka Vijay on 2/17/24.
//

import SwiftUI

struct TopAppsView: View {
    let topApps: String
    
    var body: some View {
        Text("Screentime")
        Text(topApps)
    }
}

// In order to support previews for your extension's custom views, make sure its source files are
// members of your app's Xcode target as well as members of your extension's target. You can use
// Xcode's File Inspector to modify a file's Target Membership.
