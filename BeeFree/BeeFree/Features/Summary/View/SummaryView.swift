//
//  SummaryView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.
//

import SwiftUI
import DeviceActivity
import FamilyControls
import ManagedSettings

struct SummaryView: View {
    @Binding var isDarkMode: Bool

    public var body: some View {
        Text("hello, world!")
    }
}

#Preview {
    SummaryView(isDarkMode: .constant(false))
}
