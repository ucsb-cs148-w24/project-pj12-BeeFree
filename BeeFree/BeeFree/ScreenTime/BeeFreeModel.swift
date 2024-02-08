//
//  BeeFreeModel.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 2/8/24.
//

import Foundation
import FamilyControls
import ManagedSettings

private let _BeeFreeModel = BeeFreeModel()

class BeeFreeModel: ObservableObject {
    // Import ManagedSettings to get access to the application shield restriction
    let store = ManagedSettingsStore()
    //@EnvironmentObject var store: ManagedSettingsStore
    
    @Published var selectionToDiscourage: FamilyActivitySelection
    @Published var selectionToEncourage: FamilyActivitySelection
    
    init() {
        selectionToDiscourage = FamilyActivitySelection()
        selectionToEncourage = FamilyActivitySelection()
    }
    
    class var shared: BeeFreeModel {
        return _BeeFreeModel
    }
    
    func setShieldRestrictions() {
        // Pull the selection out of the app's model and configure the application shield restriction accordingly
        let applications = BeeFreeModel.shared.selectionToDiscourage
        
        store.shield.applications = applications.applicationTokens.isEmpty ? 
            nil : applications.applicationTokens
        store.shield.applicationCategories = applications.categoryTokens.isEmpty ?
            nil : ShieldSettings.ActivityCategoryPolicy.specific(applications.categoryTokens)
    }
}
