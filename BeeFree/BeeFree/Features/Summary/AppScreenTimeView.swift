//
//  AppScreenTimeView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/22/24.
//

import SwiftUI
import DeviceActivity
import ManagedSettings
import FamilyControls

struct AppScreenTimeView: View {
    @Binding var isDarkMode : Bool
    var body: some View {
        ZStack {
            VStack {
                 DeviceActivityReport(.init("Top Apps"))
                     .frame(maxWidth: .infinity)
                     .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                Spacer()
            }
        }
    }
    
}
    
    

