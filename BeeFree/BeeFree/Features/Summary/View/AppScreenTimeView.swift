//
//  AppScreenTimeView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/22/24.
//

import SwiftUI

struct AppScreenTimeView: View {
    @Binding var isDarkMode : Bool
    var body: some View {
        RectangleSection(isDarkMode: $isDarkMode)
    }
}

#Preview {
    AppScreenTimeView(isDarkMode: .constant(false))
}
