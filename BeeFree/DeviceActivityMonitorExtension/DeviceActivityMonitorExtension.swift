//
//  DeviceActivityMonitorExtension.swift
//  BeeFreeDeviceActivityMonitor
//
//  Created by Karankumar Mageswaran on 2/8/24.
//

import DeviceActivity
import FamilyControls
import ManagedSettings
import UserNotifications
import UserNotificationsUI

// Optionally override any of the functions below.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class DeviceActivityMonitorExtension: DeviceActivityMonitor {
    let store = ManagedSettingsStore()

    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
        // Handle the start of the interval.
        let model = BeeFreeModel.shared
        let applications = model.selectionToDiscourage.applicationTokens
        let categories = model.selectionToDiscourage.categoryTokens
        let webDomains = model.selectionToDiscourage.webDomainTokens
        store.shield.applications = applications.isEmpty ?
            nil : applications
        store.shield.applicationCategories = categories.isEmpty ?
            nil : ShieldSettings.ActivityCategoryPolicy.specific(categories)
        store.shield.webDomains = webDomains.isEmpty ?
            nil : webDomains
    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        
        // Handle the end of the interval.
    }
    
    override func eventDidReachThreshold(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventDidReachThreshold(event, activity: activity)
        
        // Handle the event reaching its threshold.
        let model = BeeFreeModel.shared
        let applications = model.selectionToDiscourage.applicationTokens
        let categories = model.selectionToDiscourage.categoryTokens
        let webDomains = model.selectionToDiscourage.webDomainTokens
        store.shield.applications = applications.isEmpty ?
            nil : applications
        store.shield.applicationCategories = categories.isEmpty ?
            nil : ShieldSettings.ActivityCategoryPolicy.specific(categories)
        store.shield.webDomains = webDomains.isEmpty ?
            nil : webDomains
    }
    
    override func intervalWillStartWarning(for activity: DeviceActivityName) {
        super.intervalWillStartWarning(for: activity)
        
        // Handle the warning before the interval starts.
    }
    
    override func intervalWillEndWarning(for activity: DeviceActivityName) {
        super.intervalWillEndWarning(for: activity)
        
        // Handle the warning before the interval ends.
    }
    
    override func eventWillReachThresholdWarning(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventWillReachThresholdWarning(event, activity: activity)
        
        // Handle the warning before the event reaches its threshold.

    }
}
