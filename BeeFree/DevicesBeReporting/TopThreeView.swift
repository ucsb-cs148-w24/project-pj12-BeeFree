//
//  TopThreeView.swift
//  DevicesBeReporting
//
//  Created by Karankumar Mageswaran on 2/28/24.
//

import SwiftUI
import DeviceActivity
import ManagedSettings
import FamilyControls

 struct TopThreeView: View {
     var topThreeReport: TopThreeReport
     private let fixedColumns =  [GridItem(.fixed(100)), GridItem(.fixed(100)), GridItem(.fixed(100))]
     
     var body: some View {
          ZStack{
              LinearGradient(gradient: Gradient(colors:[Color("Sky"), Color("DarkerSky")]), startPoint:.top, endPoint: .bottom)
              VStack{
                  RectangleSection(height: 170)
                  RectangleSection(height: 396)
                  Spacer()

              }
              VStack{
                  HStack {
                      CircleProgressBar(progress: (Double(topThreeReport.totalActivityData.totalDuration) / (getSeconds() as! Double)), size:100) // fixed
                          .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 16))
                      VStack{
                          Text("Total Screentime")
                              .font(.title2)
                              .bold()
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
                      }
                  }.padding(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0))
                  VStack(alignment: .leading){
                      Text("Top Apps")
                          .font(.title2)
                          .bold()
                          .foregroundColor(Color.white)
                          .padding(EdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16))
                      ForEach(topThreeReport.apps) { app in
                          ZStack {
                              HStack {
                                  Label(app.token)
                                      .labelStyle(.iconOnly)
                                      .scaleEffect(2)
                                  VStack {
                                      Text(app.displayName)
                                          .scaledToFill()
                                          .lineLimit(1)
                                          .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                      Text(app.duration)
                                          .scaledToFill()
                                          .lineLimit(1)
                                          .foregroundColor(Color("DynamicGray"))
                                          .font(.footnote)
                                          .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                  }
                                  Spacer()
                              }
                              .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                          }
                      }
                      .frame(height: 30)
                      .background(.clear)
                      .padding()
                      Spacer()
                  }.padding(EdgeInsets(top: 45, leading: 8, bottom: 0, trailing: 0))
                  Spacer()
              }
          }
      }
     
     func getSeconds() -> Any {
         let defaults = UserDefaults(suiteName: "group.com.BeeFreeAppBlocker.mygroup") //replace suiteName with your container name
         let secs = defaults!.object(forKey: "seconds")
         return secs!
     }
 }

