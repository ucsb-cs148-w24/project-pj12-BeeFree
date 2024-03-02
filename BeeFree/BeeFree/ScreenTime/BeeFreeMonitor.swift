//
//  BeeFreeMonitor.swift
//  BeeFree
//
//  Created by Anushka Vijay on 2/23/24.
//

import Foundation
import DeviceActivity
import _DeviceActivity_SwiftUI


struct BeeFreeMonitor {
    static func applyFilter(_ filter: inout DeviceActivityFilter, from model: BeeFreeModel) {
        filter.applications = model.selectionToDiscourage.applicationTokens
        filter.categories = model.selectionToDiscourage.categoryTokens
        filter.webDomains = model.selectionToDiscourage.webDomainTokens
    }
    
//    func fetchReportData(_ filter: inout DeviceActivityFilter) {
//        DeviceActivityManager.shared.fetchReport(for: filter) {
//            result in
//            switch result {
//            case .success(let report):
//                DispatchQueue.main.async {
//                    self.reportData = report
//                }
//            case .failure(let error):
//                // Handle error
//                break
//            }
//        }
//    }
}

