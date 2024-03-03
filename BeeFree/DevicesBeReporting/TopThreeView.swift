//
//  TopThreeView.swift
//  DevicesBeReporting
//
//  Created by Karankumar Mageswaran on 2/28/24.
//

import SwiftUI

 struct TopThreeView: View {
     var topThreeReport: TopThreeReport
     private let fixedColumns =  [GridItem(.fixed(100)), GridItem(.fixed(100)), GridItem(.fixed(100))]
     
     var body: some View {
          ZStack{
              LinearGradient(gradient: Gradient(colors:[Color("Sky"), Color("DarkerSky")]), startPoint:.top, endPoint: .bottom)
              VStack{
                  HStack {
                      CircleProgressBar(progress: Double(topThreeReport.totalActivityData.totalDuration / 36000) , size:100) // fixed
                      VStack{
                          Text("Total Screentime")
                              .font(.title2)
                              .foregroundColor(.white)
                              .frame(maxWidth: .infinity)
                              .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                              .multilineTextAlignment(.trailing)
                          Text(topThreeReport.totalActivityData.totalActivity)
                              .font(.title)
                              .bold()
                              .foregroundColor(.yellow)
                              .frame(maxWidth: .infinity)
                              .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                              .multilineTextAlignment(.trailing)
                      }                     }
                  
                  card
                  Spacer()
                  }
          }
          .background(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.clear]), startPoint: .top, endPoint: .bottom))
      }
     
     var card: some View{
         VStack{
             Text("Top Apps")
                 .font(.title3)
                 .foregroundColor(Color.white)
             LazyVGrid(columns:fixedColumns, spacing:3){
                 ForEach(topThreeReport.apps){ app in
                     CardView(app:app, disablePopover: true)
                 }
             }
             Spacer()
         }
     }
 }

