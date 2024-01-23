//
//  RectangleSection.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/22/24.
//

import SwiftUI

struct RectangleSection: View {
    @Binding var isDarkMode : Bool
    var height : CGFloat
    var body: some View {
        Rectangle()
            .fill(isDarkMode ? Color("LighterSky") : Color("LighterSky"))
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .cornerRadius(10.0)
            .padding(20)
    }
}

#Preview {
    RectangleSection(isDarkMode: .constant(false), height: 100)
}
