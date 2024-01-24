//
//  CircleProgressBar.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/22/24.
//

import SwiftUI


// Credit: https://sarunw.com/posts/swiftui-circular-progress-bar/
struct CircleProgressBar: View {
    //let progress: Double
    @Binding var percents: [Double]
    let size: CGFloat = 150
    
    var body: some View {
        ZStack {
            Circle()
             .stroke(
                 Color("GreenAccent").opacity(0.5),
                 lineWidth: 30
             )
             Circle()
                 .trim(from: 0, to: percents[0])
                 .stroke(Color("GreenAccent"),
                         style: StrokeStyle(
                         lineWidth: 30,
                         lineCap: .round))
                 .rotationEffect(.degrees(-90))
                 // 1
                 .animation(.easeIn, value: percents[0])
                 .shadow(color: Color("GreenAccent").opacity(0.5), radius: 10, x: 5, y: 5)
        }.frame(width: size, height: size)
            
    }
}



#Preview {
    CircleProgressBar(percents: .constant([0.5, 0.3, 0.2]))
}
