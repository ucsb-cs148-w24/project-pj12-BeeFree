//
//  SummaryView.swift
//  BeeFree
//
//  Created by Anushka Vijay and Kaveri Iyer on 1/23/24.
//

import SwiftUI

struct SummaryView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var isDarkMode : Bool
    @State var selectedTab: Tab = .summary
    @State private var barHidden = true
    
    var body: some View {
        VStack{
            ScreenTimeGoalView(isDarkMode: $isDarkMode)
                .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
            AppScreenTimeView(isDarkMode: $isDarkMode)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        }
    }
}

#Preview {
    SummaryView(isDarkMode: .constant(false))
}
