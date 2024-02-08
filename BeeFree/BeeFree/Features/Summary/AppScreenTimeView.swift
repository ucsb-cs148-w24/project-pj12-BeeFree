//
//  AppScreenTimeView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/22/24.
//

import SwiftUI

extension Date {

 static func getCurrentDate() -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "dd/MM/yyyy"

        return dateFormatter.string(from: Date())

    }
}

struct AppScreenTimeView: View {
    @Binding var isDarkMode : Bool
    var body: some View {
        VStack{
            ZStack{
                RectangleSection(isDarkMode: $isDarkMode, height: 200)
                VStack{
                    
                    Spacer()
                    
                    Text("Today, you've used **2 hours**. Your total goal is **3 hours**. Yesterday, you used **80%** of your goal. Can you beat that today?").font(.system(size:20, design: .default)).foregroundStyle(.white)
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                }
                
                .padding([.leading, .trailing, .top], 30)
                .frame(height:200)
            }
            ZStack{
                RectangleSection(isDarkMode: $isDarkMode, height: 100)
                VStack{
                    //Spacer()
                    Text("More Coming Soon!").font(.system(size:20, weight: .semibold, design: .default)).foregroundStyle(.white)
                    
                    Spacer()
                    Spacer()
                }
                
                .padding([.bottom, .top], 30)
                .frame(height:100)
            }
        }
    }
}

#Preview {
    AppScreenTimeView(isDarkMode: .constant(false))
}
