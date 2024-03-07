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
                  RectangleSection(height: 170)
                  RectangleSection(height: 385)
                  Spacer()

              }
              VStack{
                  HStack {
                      CircleProgressBar(progress: Double(topThreeReport.totalActivityData.totalDuration / 7200) , size:100) // fixed
                          .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
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
                      ForEach(topThreeReport.apps) { app in
                          ZStack {
                              RoundedRectangle(cornerRadius: 25, style: .continuous)
                                  .fill(.clear)
                                  .shadow(radius: 10)
                                  .shadow(radius: 10)
                              
                              HStack {
                                  Label(app.token)
                                      .labelStyle(.iconOnly)
                                      .scaleEffect(2)

                                  VStack {
                                      Text(app.displayName)
                                          .scaledToFill()
                                          .lineLimit(1)
                                          .foregroundColor(.white)
                                          .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                      Text(app.duration)
                                          .scaledToFill()
                                          .lineLimit(1)
                                          .foregroundColor(Color.gray)
                                          .font(.footnote)
                                          .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                  }
                                  
                                  Spacer()
                              }.multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                          }
                      }
                      .frame(height: 28)
                      .background(.clear)
                      .padding()
                      Spacer()
                  }.padding(EdgeInsets(top: 44, leading: 8, bottom: 0, trailing: 0))
                  Spacer()
              }
          }
      }
 }

