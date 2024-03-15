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
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .cornerRadius(10.0)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
    }
}

//#Preview {
//    RectangleSection(isDarkMode: .constant(false), height: 100)
//}
