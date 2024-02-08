//  CircleProgressBar.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/22/24.
//

import SwiftUI


// Credit: https://sarunw.com/posts/swiftui-circular-progress-bar/
struct CircleProgressBar: View {
    //@Binding var trims : [Double]
    //@Binding var goals : [Double]
    //Binding var usage : [Double]
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
            
            Circle()
                .trim(from:0, to:0.67)
                .stroke(
                    Color("GreenAccent"),
                    style: StrokeStyle(
                    lineWidth: 30,
                    lineCap: .round)
                ) .rotationEffect(.degrees(-90))
            
            Text("67%").font(.system(size: 40, weight: .medium, design: .default)).foregroundStyle(.white)
            
            
        }.frame(width: size, height: size)
        
        
    }
    
}

    
    
    
    
    
    
    //    @Binding var goals: [Double]
//    @Binding var usages: [Double]
//
//    let size: CGFloat = 150
//    let colors : [String] = ["GreenAccent", "DarkerSky", "Accent Color"]
//    var sum : Double = 0
//
//
//
//    var body: some View {
//        ZStack {
//            Circle()
//                .stroke(
//                    Color("GreenAccent").opacity(0.5),
//                    lineWidth: 30
//                )
//
//            let usage_sum = sumUsage(inputUsage: usages)
//            let goals_sum = sumGoal(inputGoals: goals)
//
//            let usage_percent: Double = usage_sum/goals_sum
//
//
//
//            Circle()
//                .trim(from: 0, to: usage_percent) //+ percents[1] + percents[2])
//                           .stroke(
//                               Color("GreenAccent"),
//                               style: StrokeStyle(
//                                   lineWidth: 30,
//                                   lineCap: .round
//                               )
//                           )
//                           .rotationEffect(.degrees(-90))
//                           // 1
//                           .animation(.easeIn, value: usage_percent)
            
            

//        }.frame(width: size, height: size)
//    }


#Preview {
//    let tusages : [Double] = [1, 0.5, 0.2]
//    let tgoals : [Double] = [3,1,0.5]
    CircleProgressBar()/*goals: .constant(tgoals), usages: .constant(tusages)*/
}
