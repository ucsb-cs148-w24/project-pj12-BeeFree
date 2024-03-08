//
//  BeeFreeModel.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 2/8/24.
//

import Foundation
import FamilyControls
import ManagedSettings
import DeviceActivity

private let _BeeFreeModel = BeeFreeModel()

class BeeFreeModel: ObservableObject {
    // Import ManagedSettings to get access to the application shield restriction
    
    let store = ManagedSettingsStore()
    //@EnvironmentObject var store: ManagedSettingsStore
    
    @Published var selectionToDiscourage: FamilyActivitySelection
    @Published var thresholdToDiscourage: DateComponents
    @Published var setOfApps: [String]
    @Published var screenTimeGoal: Double
    
    init() {
        selectionToDiscourage = FamilyActivitySelection()
        thresholdToDiscourage = DateComponents()
        setOfApps = [String]()
        screenTimeGoal = 4.0
    }
    
    class var shared: BeeFreeModel {
        return _BeeFreeModel
    }
    
    func setScreenTimeGoal(x: Double) {
        screenTimeGoal = x
    }
    
    func getScreenTimeGoal() -> Double {
        return screenTimeGoal
    }
    
    func getScreenTimeGoalSecs() -> Double {
        return screenTimeGoal * 3600
    }
    
    func setShieldRestrictions() {
        // Pull the selection out of the app's model and configure the application shield restriction accordingly
        let applications = BeeFreeModel.shared.selectionToDiscourage
        let store = ManagedSettingsStore()
        store.shield.applications = applications.applicationTokens.isEmpty ?
            nil : applications.applicationTokens
        store.shield.applicationCategories = applications.categoryTokens.isEmpty ?
            nil : ShieldSettings.ActivityCategoryPolicy.specific(applications.categoryTokens)
        
        var setOfAppIdentifiers: Set<String?> = Set<String?>()
        for application in BeeFreeModel.shared.selectionToDiscourage.applications {
            setOfAppIdentifiers.insert(application.bundleIdentifier)
            setOfApps = setOfAppIdentifiers.compactMap { $0 }.sorted()
        }
    }
    
    func changeThreshold(threshold: DateComponents) {
        thresholdToDiscourage = threshold
    }
}
