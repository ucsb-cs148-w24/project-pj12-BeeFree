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
    
    @State private var shownProgress: Double = 0.0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    (progress < 0.50 ? Color("GreenAccent") :
                        (progress < 0.75 ? Color("DynamicYellow") : Color("RedAccent"))).opacity(0.5),
                    lineWidth: 12
                )
            Circle()
                .trim(from: 0, to: (shownProgress > 1.0 ? 1.0 : shownProgress))
                .stroke(
                    (progress < 0.50 ? Color("GreenAccent") :
                        (progress < 0.75 ? Color("DynamicYellow") : Color("RedAccent"))),
                    style: StrokeStyle(
                        lineWidth: 12,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                // 1
                .animation(.easeIn, value: shownProgress)

        }
        .frame(width: size, height: size)
        .onAppear {
            shownProgress += progress
        }
    }
}

//#Preview {
//    CircleProgressBar(progress: 0.73, size: 150)
//}
