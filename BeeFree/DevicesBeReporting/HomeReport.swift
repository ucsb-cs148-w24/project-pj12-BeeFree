//
//  TotalActivityReport.swift
//  DevicesBeReporting
//
//  Created by Anushka Vijay on 2/17/24.
//

import DeviceActivity
import ManagedSettings
import FamilyControls
import SwiftUI

struct HomeReport: DeviceActivityReportScene {
//    // Define which context your scene will represent.
//    let context: DeviceActivityReport.Context = .homeReport
//    
//    // Define the custom configuration and the resulting view for this report.
//    let content: (SelectedAppsReport) -> HomeReportView
//    
//    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> SelectedAppsReport {
//        // Reformat the data into a configuration that can be used
//        var list: [AppDeviceActivity] = []
//        var set = Set<AppDeviceActivity>()
////        var familySet : Set<Application> = BeeFreeModel.shared.selectionToDiscourage.applications
//    
//        for await d in data {
//            for await a in d.activitySegments{
//                for await c in a.categories {
//                    for await ap in c.applications {
//                        
//                        let this_app = ap.application
//                        let appName = (ap.application.localizedDisplayName ?? "nil")
//                        let bundle = (ap.application.bundleIdentifier ?? "nil")
//                        let category = c.category.localizedDisplayName!
//                        let duration = Int(ap.totalActivityDuration)
//                        let durationInterval = ap.totalActivityDuration
//                        let token = ap.application.token!
//                        
//                        let numberOfHours = duration / 3600
//                        let numberOfMins = (duration % 3600) / 60
//                        var formatedDuration = ""
//                        if numberOfHours == 0 {
//                            if numberOfMins != 1{
//                                formatedDuration = "\(numberOfMins)mins"
//                            }else{
//                                formatedDuration = "\(numberOfMins)min"
//                            }
//                        }else if numberOfHours == 1{
//                            if numberOfMins != 1{
//                                formatedDuration = "\(numberOfHours)hr \(numberOfMins)mins"
//                            }else{
//                                formatedDuration = "\(numberOfHours)hr \(numberOfMins)min"
//                            }
//                        }else{
//                            if numberOfMins != 1{
//                                formatedDuration = "\(numberOfHours)hrs \(numberOfMins)mins"
//                            }else{
//                                formatedDuration = "\(numberOfHours)hrs \(numberOfMins)min"
//                            }
//                        }
//                       
//                        let notifs = ap.numberOfNotifications
//                        let app = AppDeviceActivity(id: bundle, token: token, displayName: appName, duration: formatedDuration, durationInterval: durationInterval, category: category, numberOfNotifs: notifs)
////                        var v = true
////                        for other_app in set {
////                            if (other_app.id == app.id) { v = false }
////                        }
////                        if (v) {
//                            var w = false
//                            let defaults = UserDefaults(suiteName: "group.com.BeeFreeAppBlocker.mygroup")
//                            if let savedSet = defaults!.object(forKey: "selection") as? Data {
//                                let decoder = JSONDecoder()
//                                if let familySet = try? decoder.decode(FamilyActivitySelection.self, from: savedSet) {
//                                    for family_token in familySet.applicationTokens {
//                                        if (family_token == token) { w = true }
//                                    }
//                                    if (w) { set.insert(app) }
//                                }
//                            }
////                        }
//                    }
//                }
//            }
//        }
//        for app in set {
//            list.append(app)
//        }
//        return SelectedAppsReport(apps: list)
//    }
//}
    // Define which context your scene will represent.
    let context: DeviceActivityReport.Context = .homeReport
    
    // Define the custom configuration and the resulting view for this report.
    let content: (ChartAndTopThreeReport) -> HomeReportView
    
    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> ChartAndTopThreeReport {
        
        // Retrive data from each app and category
        var categoryList: [CategoryDeviceActivity] = []
        var appList: [AppDeviceActivity] = []
        
        // Format the data so we can display it in charts
        var categoryChartData:[(String,Double)] = []
        var appChartData: [(String,Double)] = []
        
        
        let totalActivityDuration = await data.flatMap { $0.activitySegments }.reduce(0, {
            $0 + $1.totalActivityDuration
        })
        
        
        for await d in data {
            for await a in d.activitySegments{
                for await c in a.categories {
                    let category = c.category
                    let hash = c.hashValue
                    let catDurationInMins = c.totalActivityDuration/60
                    
                    if catDurationInMins > 2.0{
                        categoryChartData.append((category.localizedDisplayName!, catDurationInMins))
                    }
                    
                    //                    let categoryActivity = CategoryDeviceActivity(id: hash, category: category.localizedDisplayName!, duration: duration, token: category.token!)
                    //
                    //                    categoryList.append(categoryActivity)
                    
                    for await ap in c.applications{
                        let appName = (ap.application.localizedDisplayName ?? "nil")
                        let bundle = (ap.application.bundleIdentifier ?? "nil")
                        if appName == bundle{
                            continue
                        }
                        
                        let durationInMins = Double(ap.totalActivityDuration/60)
                        if durationInMins > 2.0 {
                            appChartData.append((appName, durationInMins))
                        }
                        
                        let duration = Int(ap.totalActivityDuration)
                        let durationInterval = ap.totalActivityDuration
                        let category = c.category.localizedDisplayName!
                        let token = ap.application.token!
                        
                        let formatedDuration = formatDuration(duration:duration)
                        
                        let numberOfPickups = ap.numberOfPickups
                        let notifs = ap.numberOfNotifications
                        let app = AppDeviceActivity(id: bundle, token: token, displayName: appName, duration: formatedDuration, durationInterval: durationInterval,category: category, numberOfNotifs: notifs)
                        appList.append(app)
                    }
                }
            }
        }
        
        appList.sort(by:sortApps)
        
        return ChartAndTopThreeReport(totalDuration: totalActivityDuration, categoryChartData: categoryChartData, appChartData:appChartData, topApps: [appList[0], appList[1], appList[2]])
    }
}

func formatDuration(duration:Int) -> String{
    let numberOfHours = duration / 3600
    let numberOfMins = (duration % 3600) / 60
    var formatedDuration = ""
    if numberOfHours == 0 {
        if numberOfMins != 1{
            formatedDuration = "\(numberOfMins)mins"
        }else{
            formatedDuration = "\(numberOfMins)min"
        }
    }else if numberOfHours == 1{
        if numberOfMins != 1{
            formatedDuration = "\(numberOfHours)hr \(numberOfMins)mins"
        }else{
            formatedDuration = "\(numberOfHours)hr \(numberOfMins)min"
        }
    }else{
        if numberOfMins != 1{
            formatedDuration = "\(numberOfHours)hrs \(numberOfMins)mins"
        }else{
            formatedDuration = "\(numberOfHours)hrs \(numberOfMins)min"
        }
    }
    return formatedDuration
}

func sortCategories(this:CategoryDeviceActivity, that:CategoryDeviceActivity) -> Bool {
  return this.duration > that.duration
}

func sortApps(this:AppDeviceActivity, that:AppDeviceActivity) -> Bool {
    return this.durationInterval > that.durationInterval
}
