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

class DeviceActivityMonitorExtension: DeviceActivityMonitor {

    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
        let store = ManagedSettingsStore(named: .daily)
    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        let store = ManagedSettingsStore(named: .daily)
        store.clearAllSettings()
    }

    override func eventDidReachThreshold(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventDidReachThreshold(event, activity: activity)
        let store = ManagedSettingsStore(named: .daily)
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
    
}
