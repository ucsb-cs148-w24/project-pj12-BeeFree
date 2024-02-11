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

extension ManagedSettingsStore.Name {
    static let daily = Self("daily")
}

class BeeFreeModel: ObservableObject {
    // Import ManagedSettings to get access to the application shield restriction
    
    let store = ManagedSettingsStore()
    //@EnvironmentObject var store: ManagedSettingsStore
    
    @Published var selectionToDiscourage: FamilyActivitySelection
    @Published var thresholdToDiscourage: DateComponents
    @Published var setOfApps: [String]
    
    init() {
        selectionToDiscourage = FamilyActivitySelection()
        thresholdToDiscourage = DateComponents()
        var setOfAppIdentifiers: Set<String?> = Set<String?>()
        setOfApps = [String]()
        if selectionToDiscourage.applicationTokens.isEmpty {}
        else {
            for application in BeeFreeModel.shared.selectionToDiscourage.applications {
                setOfAppIdentifiers.insert(application.localizedDisplayName)
                setOfApps = setOfAppIdentifiers.compactMap { $0 }.sorted()
            }
        }
    }
    
    class var shared: BeeFreeModel {
        return _BeeFreeModel
    }
    
    func setSelection() {
        let applications = BeeFreeModel.shared.selectionToDiscourage
    }
    
    func setShieldRestrictions() {
        let applications = BeeFreeModel.shared.selectionToDiscourage
        let store = ManagedSettingsStore(named: .daily)
        store.shield.applications = applications.applicationTokens.isEmpty ?
            nil : applications.applicationTokens
        store.shield.applicationCategories = applications.categoryTokens.isEmpty ?
            nil : ShieldSettings.ActivityCategoryPolicy.specific(applications.categoryTokens)
        
        var setOfAppIdentifiers: Set<String?> = Set<String?>()
        for application in BeeFreeModel.shared.selectionToDiscourage.applications {
            setOfAppIdentifiers.insert(application.localizedDisplayName)
            setOfApps = setOfAppIdentifiers.compactMap { $0 }.sorted()
        }
    }
    
    func changeThreshold(threshold: DateComponents) {
        thresholdToDiscourage = threshold
    }
}
