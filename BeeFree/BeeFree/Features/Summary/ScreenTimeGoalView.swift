//
//  ScreenTimeGoalView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/22/24.
//

import SwiftUI
import DeviceActivity
import ManagedSettings

struct ScreenTimeGoalView: View {
    @Binding var isDarkMode : Bool
    var body: some View {
        ZStack {
            //RectangleSection(height: 300)
            HStack{
                VStack{
                    Text("Today's Screentime:")
                        .font(.headline)
                        .padding(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0))
                    DeviceActivityReport(.init("Total Activity"))
                        .frame(maxWidth: .infinity, maxHeight: 64)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
                }
                CircleProgressBar(progress: 0.33, size: 125)
                    .padding()
            }
            .padding([.trailing], 16)
        }
    }
}

#Preview {
    ScreenTimeGoalView(isDarkMode: .constant(false))
}
