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
            .fill(Color("LighterSky"))
            .background(.ultraThinMaterial)
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .cornerRadius(16.0)
            .padding(20)
    }
}

#Preview {
    RectangleSection(isDarkMode: .constant(false), height: 100)
}
