//
//  TotalActivityView.swift
//  DevicesBeReporting
//
//  Created by Anushka Vijay on 2/17/24.
//

import SwiftUI

struct TotalActivityView: View {
    let totalActivity: String
    
    var body: some View {
        Text(totalActivity)
            .font(.title2)
            .bold()
            .foregroundColor(.yellow)
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
    }
}
