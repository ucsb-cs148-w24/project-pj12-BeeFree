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
import CoreHaptics

struct HapticFeedback: ViewModifier {
  private let generator: UIImpactFeedbackGenerator

  init(style: UIImpactFeedbackGenerator.FeedbackStyle) {
    generator = UIImpactFeedbackGenerator(style: style)
  }

  func body(content: Content) -> some View {
    content
      .onTapGesture(perform: generator.impactOccurred)
  }
}

extension View {
  func hapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle = .rigid) -> some View {
    self.modifier(HapticFeedback(style: style))
  }
}

extension Color{
    static let borderColor = Color("border")
}

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
                    .frame(width:50, height:50)
                    .scaleEffect(3)
                    .padding(4)
                    .mask(RoundedRectangle(cornerRadius: 8, style:.continuous))
                    .shadow(color:Color("shadowColor").opacity(0.7), radius:5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8, style:.continuous)
                            .stroke(Color.borderColor, lineWidth: 2)
                       )
                    
                    
                Text(app.displayName)
                    .font(.subheadline)
                    .scaledToFill()
                    .minimumScaleFactor(0.2)
                    .lineLimit(1)
                    
            }
            .padding()
            .multilineTextAlignment(.center)
            
        }
        .frame(width: 90, height:60)
        .padding()
        .scaleEffect(tapped ? 1.4 : 1)
        .animation(.spring(response: 0.4, dampingFraction: 0.6))
        .onTapGesture{
            var temp = UIImpactFeedbackGenerator(style:.heavy)
            temp.impactOccurred()
            if !disablePopover{
                tapped.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    tapped.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                    showInfo.toggle()
                }
            }
        }
        .popover(isPresented: $showInfo, arrowEdge: .bottom) {
            CardViewPopup(app:app)
        }
    }
}

struct CardViewPopup: View {
    let app: AppDeviceActivity
    var body: some View {
        ZStack{
            Color("backgroundColor").opacity(0.8)
            VStack{
                Label(app.token)
                    .labelStyle(.iconOnly)
                    .frame(width:50, height:50)
                    .scaleEffect(3)
                    .padding(4)
                    .mask(RoundedRectangle(cornerRadius: 8, style:.continuous))
                    .shadow(color:Color("shadowColor").opacity(0.7), radius:5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8, style:.continuous)
                            .stroke(Color.borderColor, lineWidth: 2)
                    )
                Text(app.displayName)
                    .font(.title2)
                Spacer()
                HStack {
                    Text("Application Category:")
                        .font(.subheadline)
                    Text("\(app.category)")
                        .font(.subheadline)
                }
                Spacer()
                HStack {
                    Text("Total Number of Notifications:")
                        .font(.subheadline)
                    Text("\(app.numberOfNotifs)")
                        .font(.subheadline)
                }
                Spacer()
                HStack {
                    Text("Screen Time:")
                        .font(.subheadline)
                    Text("\(app.duration)")
                        .font(.subheadline)
                }
            }
            .fixedSize()
        }
        //.frame(width: .infinity, height: 200)
    }
}
