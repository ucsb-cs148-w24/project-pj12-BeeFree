//
//  ScreenTimeGoalView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/22/24.
//
import SwiftUI

struct ScreenTimeGoalView: View {
    @Binding var isDarkMode : Bool
    //var percents: [Double] = []
    @State var percents: [Double] = []
    
    
    var body: some View {
        ZStack {
            RectangleSection(isDarkMode: $isDarkMode, height: 200)
            VStack {
//                Text("Today's Screen Time")
                HStack {
                    Spacer()
                    CircleProgressBar(percents: .constant([0.5, 0.3, 0.2]))
                }
                .padding([.leading, .trailing], 50)
            }
        }
    }
}

#Preview {
    ScreenTimeGoalView(isDarkMode: .constant(false))
}
