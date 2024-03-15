//
//  AppLimitDisplay.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/22/24.
//

import SwiftUI

struct AppLimitDisplay: View {
    @Binding var isDarkMode : Bool
    @State var appName : String
    var body: some View {
        Text(appName)
            .fixedSize(horizontal: false, vertical: true)
            .foregroundColor(Color("DynamicGray"))
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity)
            .frame(height:81)
            .padding()
            .background(Rectangle()
                .fill(Color("LighterSky"))
                .background(.ultraThinMaterial)
                .frame(maxWidth: .infinity)
                .cornerRadius(10.0)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)))

    }
}

#Preview {
    AppLimitDisplay(isDarkMode: .constant(false), appName: "BeeFree")
}
