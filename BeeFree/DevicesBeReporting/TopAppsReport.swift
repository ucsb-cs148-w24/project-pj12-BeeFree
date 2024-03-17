//
//  TotalActivityReport.swift
//  DevicesBeReporting
//
//  Created by Anushka Vijay on 2/17/24.
//

import DeviceActivity
import SwiftUI

extension DeviceActivityReport.Context {
    // If your app initializes a DeviceActivityReport with this context, then the system will use
    // your extension's corresponding DeviceActivityReportScene to render the contents of the
    // report.
    static let topApps = Self("Top Apps")
    static let homeReport = Self("Home Report")
}

struct TopAppsReport: DeviceActivityReportScene {
    
    // Define which context your scene will represent.
    let context: DeviceActivityReport.Context = .topApps
    
    // Define the custom configuration and the resulting view for this report.
    let content: (TopThreeReport) -> TopThreeView
    
    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> TopThreeReport {
        //Total activity
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .dropAll
                
        let totalActivityDuration = await data.flatMap { $0.activitySegments }.reduce(0, {
            $0 + $1.totalActivityDuration
        })
        
        let totalActivityOutput = TotalActivityReportData(totalDuration: totalActivityDuration, totalActivity: formatter.string(from: totalActivityDuration) ?? "No activity data")
        
        
        // Reformat the data into a configuration that can be used
        var listTime: [AppDeviceActivity] = []
        var listPickups: [AppDeviceActivity] = []
        var set = Set<AppDeviceActivity>()
        
        for await d in data {
            for await a in d.activitySegments{
                for await c in a.categories {
                    for await ap in c.applications {
                        
                        let appName = (ap.application.localizedDisplayName ?? "nil")
                        let bundle = (ap.application.bundleIdentifier ?? "nil")
                        let duration = Int(ap.totalActivityDuration)
                        let durationInterval = ap.totalActivityDuration
                        let category = c.category.localizedDisplayName!
                        let token = ap.application.token!
                        
                        let numberOfHours = duration / 3600
                        let numberOfMins = (duration % 3600) / 60
                        var formatedDuration = ""
                        if numberOfHours == 0 {
                            if numberOfMins != 1{
                                formatedDuration = "\(numberOfMins) mins"
                            }else{
                                formatedDuration = "\(numberOfMins) min"
                            }
                        }else if numberOfHours == 1{
                            if numberOfMins != 1{
                                formatedDuration = "\(numberOfHours) hr \(numberOfMins) mins"
                            }else{
                                formatedDuration = "\(numberOfHours) hr \(numberOfMins) min"
                            }
                        }else{
                            if numberOfMins != 1{
                                formatedDuration = "\(numberOfHours) hrs \(numberOfMins) mins"
                            }else{
                                formatedDuration = "\(numberOfHours) hrs \(numberOfMins) min"
                            }
                        }
                        let numberOfPickups = ap.numberOfPickups + 1
                        let notifs = ap.numberOfNotifications
                        let app = AppDeviceActivity(id: bundle, token: token, displayName: appName, duration: formatedDuration, durationInterval: durationInterval, numberOfPickups: numberOfPickups, category: category, numberOfNotifs: notifs)
                        var v = true
                        for other_app in set {
                            if (other_app.id == app.id) { v = false }
                        }
                        if (v) { set.insert(app) }
                    }
                }
            }
        }
        for app in set {
            listTime.append(app)
            listPickups.append(app)
        }
        listTime.sort(by: sortAppsTime)
        listPickups.sort(by: sortAppsPickups)
        if listTime.count < 5{
            if listTime.count == 4{
                return TopThreeReport(appsTime: [listTime[0], listTime[1], listTime[2], listTime[3]], appsPickups: [listPickups[0], listPickups[1], listPickups[2], listPickups[3]] , totalActivityData: totalActivityOutput)
            }
            if listTime.count == 3{
                return TopThreeReport(appsTime: [listTime[0], listTime[1], listTime[2]], appsPickups: [listPickups[0], listPickups[1], listPickups[2]] , totalActivityData: totalActivityOutput)
            }
            if listTime.count == 2{
                return TopThreeReport(appsTime: [listTime[0], listTime[1]], appsPickups: [listPickups[0], listPickups[1]] , totalActivityData: totalActivityOutput)
            }
            if listTime.count == 1{ 
                return TopThreeReport(appsTime: [listTime[0]], appsPickups: [listPickups[0]] , totalActivityData: totalActivityOutput)
            }
            if listTime.count == 0{
                return TopThreeReport(appsTime: [], appsPickups: [] , totalActivityData: totalActivityOutput)
            }
        }
        return TopThreeReport(appsTime: [listTime[0], listTime[1], listTime[2], listTime[3], listTime[4]], appsPickups: [listPickups[0], listPickups[1], listPickups[2], listPickups[3], listPickups[4]] , totalActivityData: totalActivityOutput)
    }
    
    func sortAppsTime(this:AppDeviceActivity, that:AppDeviceActivity) -> Bool {
        return this.durationInterval > that.durationInterval
    }
    
    func sortAppsPickups(this:AppDeviceActivity, that:AppDeviceActivity) -> Bool {
        return (this.numberOfPickups == that.numberOfPickups ? this.durationInterval > that.durationInterval : this.numberOfPickups > that.numberOfPickups)
    }
}
