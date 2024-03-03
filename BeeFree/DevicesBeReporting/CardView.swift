//
//  CardView.swift
//  DevicesBeReporting
//
//  Created by Karankumar Mageswaran on 2/28/24.
//

import SwiftUI
import DeviceActivity
import ManagedSettings
import FamilyControls

struct CardView: View {
    let app: AppDeviceActivity
    let disablePopover:Bool
    
    @State private var tapped = false
    @State private var showInfo = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(.clear)
                .shadow(radius: 10)
                .shadow(radius: 10)
            
            VStack {
                Label(app.token)
                    .labelStyle(.iconOnly)
                    .scaleEffect(2)
//                    .frame(width:50, height:50)
//                    .padding(4)

                Text(app.displayName)
                    .scaledToFill()
                    .minimumScaleFactor(0.2)
                    .lineLimit(1)
                    .foregroundColor(Color.white)
                    
            }
            .padding()
            .multilineTextAlignment(.center)
        }
//        .frame(width: 90, height:60)
//        .padding()
//        .scaleEffect(tapped ? 1.4 : 1)
//        .animation(.spring(response: 0.4, dampingFraction: 0.6))
//        .onTapGesture{
//            var temp = UIImpactFeedbackGenerator(style:.heavy)
//            temp.impactOccurred()
//            if !disablePopover{
//                tapped.toggle()
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                    tapped.toggle()
//                }
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
//                    showInfo.toggle()
//                }
//            }
//        }
    }
}
