//
//  CreateLimitSheetView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.
//

import SwiftUI
import FamilyControls
import DeviceActivity

struct CreateLimitSheetView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @Binding var isDarkMode: Bool
    
    let center = AuthorizationCenter.shared
    @State private var context: DeviceActivityReport.Context = .init(rawValue: "Total Activity")

    @State var filter = DeviceActivityFilter()
    
    @State var isPresented = false
    @State var selection = FamilyActivitySelection()
    
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    CreateLimitSheetView(isDarkMode: .constant(false))
}
