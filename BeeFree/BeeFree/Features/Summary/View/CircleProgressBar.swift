//  CircleProgressBar.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/22/24.
//

import SwiftUI


// Credit: https://sarunw.com/posts/swiftui-circular-progress-bar/
struct CircleProgressBar: View {
    @Binding var trims : [Double]
    let size: CGFloat = 150
    let colors : [String] = ["GreenAccent", "DarkerSky", "Accent Color"]
    var sum : Double = 0
    
    
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color("GreenAccent").opacity(0.5),
                    lineWidth: 30
                )
            
            ForEach((1...trims.count).reversed(), id: \.self) {
                Circle()
                    .trim(from: 0, to: trims[$0]) //+ percents[1] + percents[2])
                    .stroke(
                        Color("GreenAccent"),
                        style: StrokeStyle(
                            lineWidth: 30,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                    // 1
                    .animation(.easeIn, value: trims[$0])
               }
            
            
            
//            for i in stride(from:trims.count, to:0, by:-1){
//                Circle()
//                    .trim(from: 0, to: trims[i]) //+ percents[1] + percents[2])
//                    .stroke(
//                        Color("GreenAccent"),
//                        style: StrokeStyle(
//                            lineWidth: 30,
//                            lineCap: .round
//                        )
//                    )
//                    .rotationEffect(.degrees(-90))
//                    // 1
//                    .animation(.easeIn, value: trims[i])
//                
//            }
            
//            Circle()
//                .trim(from: 0, to: percents[0]) //+ percents[1] + percents[2])
//                .stroke(
//                    Color("GreenAccent"),
//                    style: StrokeStyle(
//                        lineWidth: 30,
//                        lineCap: .round
//                    )
//                )
//                .rotationEffect(.degrees(-90))
//                // 1
//                .animation(.easeIn, value: percents[0]) /*+ percents[1] + percents[2])*/
//            
//         /*   Circle()
//                .trim(from: 0, to: percents[1] + percents[2])
//                .stroke(
//                    Color("DarkerSky"),
//                    style: StrokeStyle(
//                        lineWidth: 30,
//                        lineCap: .round
//                    )
//                )
//                .rotationEffect(.degrees(-90))
//                // 1
//                .animation(.easeIn, value: percents[1] + percents[2])
//            
//            Circle()
//                .trim(from: 0, to: percents[2])
//                .stroke(
//                    Color("AccentColor"),
//                    style: StrokeStyle(
//                        lineWidth: 30,
//                        lineCap: .round
//                    )
//                )
//                .rotationEffect(.degrees(-90))
//                // 1
//                .animation(.easeIn, value: percents[2]) */
            
            
            

        }.frame(width: size, height: size)
    }
}

#Preview {
    CircleProgressBar(trims: .constant([0.5]))
}
