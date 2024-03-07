//
//  CircleProgressBar.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/22/24.
//

import SwiftUI


// Credit: https://sarunw.com/posts/swiftui-circular-progress-bar/
struct CircleProgressBar: View {
    let progress: Double
    let size: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    (progress < 0.50 ? Color("GreenAccent") :
                        (progress < 0.75 ? Color("YellowAccent") : Color("RedAccent"))).opacity(0.5),
                    lineWidth: 24
                )
            Circle()
                .trim(from: 0, to: (progress > 1.0 ? 1.0 : progress))
                .stroke(
                    (progress < 0.50 ? Color("GreenAccent") :
                        (progress < 0.75 ? Color("YellowAccent") : Color("RedAccent"))),
                    style: StrokeStyle(
                        lineWidth: 24,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                // 1
                .animation(.easeIn, value: progress)

        }.frame(width: size, height: size)
    }
}

#Preview {
    CircleProgressBar(progress: 0.73, size: 150)
}
