//
//  PollenAnimation.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/23/24.
//

import SwiftUI

struct PollenAnimation: View {
    @Binding var isDarkMode : Bool
    @State var run = false
    var body: some View {
        // CREDIT: https://stackoverflow.com/questions/63636548/having-trouble-creating-a-star-animation-in-swiftui
            GeometryReader { gp in
                ForEach(0..<8) {_ in
                    ForEach(0..<5) { _ in
                        Circle().fill(isDarkMode ? Color("DarkerSky") : .white)
                            .frame(width: 3, height: 3)
                            .position(x: calculateRandom(in: gp.size.width),
                                      y: calculateRandom(in: gp.size.height))
                            .blur(radius: run ? 4 : 2)
                    }
                }
            }
            .animation(Animation.easeInOut(duration: 33)
            .repeatForever(autoreverses: true), value: run) // animate one value
            .onAppear() {
                self.run = true
                    }
    }
    func calculateRandom(in value: CGFloat) -> CGFloat {
        return CGFloat(Int.random(in: 10..<Int(value) - 10))
    }
}

#Preview {
    PollenAnimation(isDarkMode: .constant(false))
}
