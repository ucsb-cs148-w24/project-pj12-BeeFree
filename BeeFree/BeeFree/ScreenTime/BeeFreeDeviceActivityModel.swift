//
//  DeviceActivityModel.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 2/8/24.
//

import Foundation
import DeviceActivity
import ManagedSettings


class BeeFreeDeviceActivityMonitor: DeviceActivityMonitor {
    override func intervalDidStart(for activity: DeviceActivityName) {
        print("intervalDidStart")
        super.intervalDidStart(for: activity)
    }

    override func intervalDidEnd(for activity: DeviceActivityName) {
        print("intervalDidEnd")
        super.intervalDidEnd(for: activity)
    }

    override func eventDidReachThreshold(_ event:DeviceActivityEvent.Name, activity:DeviceActivityName){
        print("eventDidReachThreshold")
        super.eventDidReachThreshold(event, activity: activity)
    }
}

