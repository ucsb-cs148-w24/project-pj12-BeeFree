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
     
     @State private var shownProgress : Double = 0.0
     @State private var sortByTime: Bool = true
     
     var body: some View {
          ZStack{
              Color("Sky")
                  .edgesIgnoringSafeArea(.all)
              VStack{
                  RectangleSection(height: 170)
                      .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                  RectangleSection(height: 322)
                      .padding(EdgeInsets(top: 64, leading: 0, bottom: 16, trailing: 0))
                 Spacer()

              }
              VStack{
                  HStack {
//                      CircleProgressBar(progress: (Double(topThreeReport.totalActivityData.totalDuration) / (getSeconds() as! Double)), size:100) // fixed
                      ZStack {
                          Circle()
                              .stroke(
                                  ( (Double(topThreeReport.totalActivityData.totalDuration) / (getSeconds() as! Double)) < 0.75 ? Color("GreenAccent") :
                                        ( (Double(topThreeReport.totalActivityData.totalDuration) / (getSeconds() as! Double)) <= 1.0 ? Color("DynamicYellow") : Color("RedAccent"))).opacity(0.5),
                                  lineWidth: 24
                              )
                          Circle()
                              .trim(from: 0, to: ((Double(topThreeReport.totalActivityData.totalDuration) / (getSeconds() as! Double)) > 1.0 ? 1.0 : (Double(topThreeReport.totalActivityData.totalDuration) / (getSeconds() as! Double))))
                              .stroke(
                                  ( (Double(topThreeReport.totalActivityData.totalDuration) / (getSeconds() as! Double)) < 0.75 ? Color("GreenAccent") :
                                        ( (Double(topThreeReport.totalActivityData.totalDuration) / (getSeconds() as! Double)) <= 1.0 ? Color("DynamicYellow") : Color("RedAccent"))),
                                  style: StrokeStyle(
                                      lineWidth: 24,
                                      lineCap: .round
                                  )
                              )
                              .rotationEffect(.degrees(-90))
                              // 1
                      }
                      .frame(width: 96, height: 96)
                      .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 16))
                      VStack{
                          Text("Total Screentime")
                              .textCase(.uppercase)
                              .font(.subheadline)
                              .foregroundColor(.white)
                              .frame(maxWidth: .infinity)
                              .padding(EdgeInsets(top: 0, leading: 16, bottom: 4, trailing: 16))
                              .frame(alignment: .trailing)
                          Text(topThreeReport.totalActivityData.totalActivity)
                              .font(.system(.title, design: .rounded))
                              .bold()
                              .foregroundColor(.yellow)
                              .frame(maxWidth: .infinity)
                              .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                              .frame(alignment: .trailing)
                          
                          Text("Your Goal")
                              .textCase(.uppercase)
                              .font(.subheadline)
                              .foregroundColor(.white)
                              .frame(maxWidth: .infinity)
                              .padding(EdgeInsets(top: 0, leading: 16, bottom: 4, trailing: 16))
                              .frame(alignment: .trailing)
//                          Text(topThreeReport.totalActivityData.totalActivity)
//                              .font(.system(.title, design: .rounded))
//                              .bold()
//                              .foregroundColor(.yellow)
//                              .frame(maxWidth: .infinity)
//                              .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
//                              .frame(alignment: .trailing)
                          Text(formatTime(seconds: (getSeconds() as! Int)))
                              .font(.system(.title, design: .rounded))
                              .foregroundColor(.yellow)
                              .frame(maxWidth: .infinity)
                              .padding(EdgeInsets(top: -4, leading: 16, bottom: 16, trailing: 16))
                              .frame(alignment: .trailing)
                      }.padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                  }.padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                  VStack(alignment: .leading){
                      HStack {
                          Text("Top Apps")
                              .font(.title2)
                              .bold()
                              .foregroundColor(Color.white)
                              .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                          Spacer()
                          Picker(selection: $sortByTime, label: Text("Sort By:")) {
                              Text("Time").tag(true).foregroundColor(.white)
                              Text("Pickups").tag(false).foregroundColor(.white)
                          }
                          .pickerStyle(SegmentedPickerStyle())
                          .tint(Color("LighterSky"))
                      }
                      ZStack {
                          VStack {
                              Divider().padding(EdgeInsets(top: 80, leading: 0, bottom: 27, trailing: 0))
                              Divider().padding(EdgeInsets(top: 28, leading: 0, bottom: 27, trailing: 0))
                              Divider().padding(EdgeInsets(top: 28, leading: 0, bottom: 27, trailing: 0))
                              Divider().padding(EdgeInsets(top: 28, leading: 0, bottom: 27, trailing: 0))
                              Spacer()
                          }
                          VStack {
                              ForEach(sortByTime ? topThreeReport.appsTime : topThreeReport.appsPickups) { app in
                                  ZStack {
                                      HStack {
                                          Label(app.token)
                                              .labelStyle(.iconOnly)
                                              .scaleEffect(2)
                                              .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 4))
                                          VStack {
                                              Text(app.displayName)
                                                  .scaledToFill()
                                                  .lineLimit(1)
                                                  .foregroundColor(.white)
                                                  .frame(maxWidth: .infinity, alignment: .leading)
                                              Text(app.category)
                                                  .scaledToFill()
                                                  .lineLimit(1)
                                                  .foregroundColor(Color("DynamicGray"))
                                                  .font(.footnote)
                                                  .frame(maxWidth: .infinity, alignment: .leading)
                                          }
                                          Spacer()
                                          VStack(alignment: .trailing) {
                                              Text(app.duration)
                                                  .scaledToFill()
                                                  .lineLimit(1)
                                                  .foregroundColor(.white)
                                                  .font(.footnote)
                                                  .frame(maxWidth: .infinity, alignment: .trailing)
                                              Text(String(app.numberOfPickups) +  (String(app.numberOfPickups) == "1" ? " pickup" : " pickups"))
                                                  .scaledToFill()
                                                  .lineLimit(1)
                                                  .foregroundColor(.white)
                                                  .font(.footnote)
                                                  .frame(maxWidth: .infinity, alignment: .trailing)
                                          }
                                      }
                                      .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                  }
                              }
                              .frame(height: 30)
                              .background(.clear)
                              .padding(EdgeInsets(top: 16, leading: 16, bottom: 10, trailing: 16))
                              Spacer()
                          }.padding(EdgeInsets(top: 10, leading: 8, bottom: -64, trailing: 0))
                      }.padding(EdgeInsets(top: 0, leading: 0, bottom: -24, trailing: 0))
                  }.padding(EdgeInsets(top: 36, leading: 0, bottom: 0, trailing: 0))
                  Spacer()
                  Spacer()
              }
          }
      }
     
     func getSeconds() -> Any {
         let defaults = UserDefaults(suiteName: "group.com.BeeFreeAppBlocker.mygroup") //replace suiteName with your container name
         let secs = defaults!.object(forKey: "seconds")
         return secs!
     }
     
     func formatTime(seconds: Int) -> String {
         let hours = seconds / 3600
         let minutes = (seconds % 3600) / 60

         if minutes == 0 {
             return "\(hours)h"
         } else if minutes == 30 {
             return "\(hours)h 30m"
         } else {
             return "\(hours)h"
         }
     }
 }

