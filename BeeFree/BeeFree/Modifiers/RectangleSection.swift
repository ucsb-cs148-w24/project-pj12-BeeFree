//
//  RectangleSection.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/22/24.
//

import SwiftUI

struct RectangleSection: View {
    var height : CGFloat
    var body: some View {
        Rectangle()
            .fill(Color("LighterSky"))
            .background(.ultraThinMaterial)
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .cornerRadius(16.0)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
    }
}

//#Preview {
//    RectangleSection(isDarkMode: .constant(false), height: 100)
//}
