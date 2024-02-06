//
//  PercentMath.swift
//  BeeFree
//
//  Created by Kaveri Iyer on 1/23/24.
//

import Foundation
import SwiftUI

func getUsage(uid : String)  -> Binding<[Double]>{
    // returns double array of user's used apps
    
    var returnval : [Double] = [0.0]
    return Binding(get : {returnval}, set: {returnval = $0})
}

func getGoal(uid : String) -> Binding<[Double]>{
    // returns double array of user's app goals
    
    var returnval : [Double] = [0.0]
    return Binding(get : {returnval}, set: {returnval = $0})
}

// divide usage/goals
// now you have usage percentage for each app
// sort usage% in order max -> min
// return 1+2+3, 1+2, 1
// also return sum(usage - 1 2 3)/sum(goals - 1 2 3)
func calculateTrims(inputPercents : [Double]) -> Binding<[Double]>{
    // go into firebase
    // get users goals, get users usage
    var trims: [Double] = []
    var sum: Double = 0.0
    for percent in inputPercents{
        sum += percent
        trims.append(sum)
    }
    
    for i in stride(from:trims.count, to:0, by:-1){
        
    }
    // var returnval : [Double] = [0.5]
    return Binding(get : {trims}, set: {trims = $0})
}
