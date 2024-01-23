//
//  HomeView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.
//

import SwiftUI

struct HomeView: View {
    @Binding var isDarkMode : Bool
    var body: some View {
        VStack {
            AppLimitList(isDarkMode: $isDarkMode)
            Spacer()
        }
    }
}

#Preview {
    HomeView(isDarkMode: .constant(false))
}
