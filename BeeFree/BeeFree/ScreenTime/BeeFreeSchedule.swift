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

// The Device Activity name is how I can reference the activity from within my extension
extension DeviceActivityName {
    // Set the name of the activity to "daily"
    static let daily = Self("daily")
}

// I want to add an application shield restriction when threshold usage for a set of apps is reached
extension DeviceActivityEvent.Name {
    // Set the name of the event to "discouraged"
    static let discouraged = Self("discouraged")
}

// The Device Activity schedule represents the time bounds in which my extension will monitor for activity
let schedule = DeviceActivitySchedule(
    intervalStart: DateComponents(hour: 0, minute: 0),
    intervalEnd: DateComponents(hour: 23, minute: 59),
    repeats: true
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
        
        // Create a Device Activity center
        let center = DeviceActivityCenter()
        do {
            print("Try to start monitoring...")
            // Call startMonitoring with the activity name, schedule, and events
            try center.startMonitoring(.daily, during: schedule, events: events)
        } catch {
            print("Error monitoring schedule: ", error)
        }
    }
}

// Another ingredient to shielding apps is figuring out what the guardian wants to discourage
// The Family Controls framework has a SwiftUI element for this: the family activity picker
