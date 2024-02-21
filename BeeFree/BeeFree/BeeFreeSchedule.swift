//
//  BeeFreeSchedule.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 2/8/24.
//

import Foundation
import DeviceActivity
import FamilyControls
import ManagedSettings

extension DeviceActivityName {
    static let daily = Self("daily")
}

extension DeviceActivityEvent.Name {
    static let discouraged = Self("discouraged")
}

let schedule = DeviceActivitySchedule(
    intervalStart: DateComponents(hour: 0, minute: 0, second: 0),
    intervalEnd: DateComponents(hour: 23, minute: 59, second: 59),
    repeats: true,
    warningTime: nil
)

class BeeFreeSchedule {
    static public func setSchedule() {
        print("Setting schedule...")
        print("Hour is: ", Calendar.current.dateComponents([.hour, .minute], from: Date()).hour!)

        let events: [DeviceActivityEvent.Name: DeviceActivityEvent] = [
            .discouraged: DeviceActivityEvent(
                applications: BeeFreeModel.shared.selectionToDiscourage.applicationTokens,
                categories: BeeFreeModel.shared.selectionToDiscourage.categoryTokens,
                webDomains: BeeFreeModel.shared.selectionToDiscourage.webDomainTokens,
                threshold: BeeFreeModel.shared.thresholdToDiscourage
            )
        ]
        
        let center = DeviceActivityCenter()
        do {
            print("Try to start monitoring...")
            center.stopMonitoring([.daily])
            // Call startMonitoring with the activity name, schedule, and events
            try center.startMonitoring(.daily, during: schedule, events: events)
        } catch {
            print("Error monitoring schedule: ", error)
        }
    }
}   
