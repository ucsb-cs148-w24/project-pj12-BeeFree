//
//  TopThreeView.swift
//  DevicesBeReporting
//
//  Created by Karankumar Mageswaran on 2/28/24.
//

import SwiftUI
import SwiftUICharts
import DeviceActivity
import ManagedSettings
import FamilyControls

struct HomeReportView: View {
    
//    var selectedAppsReport: SelectedAppsReport
//    
//    var body: some View {
//        Text("Hello, world!")
//        ZStack{
//            LinearGradient(gradient: Gradient(colors:[Color("Sky"), Color("DarkerSky")]), startPoint:.top, endPoint: .bottom)
//            VStack{
//                RectangleSection(height: 396)
//                Spacer()
//                
//            }
//            VStack{
//                VStack(alignment: .leading){
//                    Text("Top Apps")
//                        .font(.title2)
//                        .bold()
//                        .foregroundColor(Color.white)
//                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16))
//                    ForEach(selectedAppsReport.apps) { app in
//                        ZStack {
//                            HStack {
//                                Label(app.token)
//                                    .labelStyle(.iconOnly)
//                                    .scaleEffect(2)
//                                VStack {
//                                    Text(app.displayName)
//                                        .scaledToFill()
//                                        .lineLimit(1)
//                                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
//                                }
//                                Spacer()
//                            }
//                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
//                        }
//                    }
//                    .frame(height: 30)
//                    .background(.clear)
//                    .padding()
//                    Spacer()
//                }.padding(EdgeInsets(top: 45, leading: 8, bottom: 0, trailing: 0))
//                Spacer()
//            }
//        }
//    }
//}
    
    
     var homeReport: ChartAndTopThreeReport
         private let fixedColumns =  [GridItem(.fixed(80)), GridItem(.fixed(80)), GridItem(.fixed(80))]
         
         var body: some View {
             ZStack {
                 Color("Sky")
                     .edgesIgnoringSafeArea(.all)
            
                 VStack{
//                     card
//                         
//                     Spacer(minLength:20)

                     Rectangle()
                         .fill(Color("border"))
                         .frame(width:200, height: 3)
                         .edgesIgnoringSafeArea(.horizontal)
                         .background(.clear)
                     
                     TabView {
                         BarChartView(data: ChartData(values: homeReport.categoryChartData),
                                      title: "Category Minutes",legend: "Categories",
                                      style: Styles.barChartMidnightGreenLight,
                                      form:ChartForm.extraLarge,dropShadow:true,
                                      cornerImage:Image(systemName:"clock"))
                         BarChartView(data: ChartData(values: homeReport.appChartData),
                                      title: "App Minutes", legend: "App Time",
                                      style: Styles.barChartStyleNeonBlueLight,
                                      form:ChartForm.extraLarge ,
                                      dropShadow:true,
                                      cornerImage:Image(systemName:"apps.iphone"))
                     }
                     .frame(height:320)
                     .layoutPriority(1)
                     .tabViewStyle(.page)
                     .background(Color("Sky"))
//                     .indexViewStyle(
//                     .page(backgroundDisplayMode:
//                                 .always))
                 }
                 
             }
         }
//         var card: some View{
//             VStack(alignment:.center){
//                 Text("Top Apps")
//                     .font(.title2)
//                 
//                 Rectangle()
//                     .fill(Color("border"))
//                     .frame(width:150, height: 3)
//                     .edgesIgnoringSafeArea(.horizontal)
//                 
//                 LazyVGrid(columns:fixedColumns, spacing:2){
//                     ForEach(homeReport.topApps){ app in
//                         CardView(app:app, disablePopover: false)
//                     }
//                 }
//             }
//             .padding()
//
//         }
 }

