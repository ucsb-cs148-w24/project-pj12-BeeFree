//
//  HomeView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.
//

import SwiftUI
import DeviceActivity
import ManagedSettings
import FamilyControls

func formatDouble(_ value: Double) -> String {
    if value.truncatingRemainder(dividingBy: 1.0) == 0.0 {
        return String(format: "%.0f", value)
    } else {
        return String(value)
    }
}

struct HomeView: View {
    @Binding var isDarkMode : Bool
    @Binding var set: [String]
    @EnvironmentObject var store: ManagedSettingsStore
    @EnvironmentObject var model: BeeFreeModel
    @State var selection = FamilyActivitySelection()
    
    @State private var isScreenTimeGoalPresented = false
    @State private var isDiscouragedPresented = false
    @State private var isUserManualPresented = false
    
    @State var delay = 0.0
    
    @State private var padding_0 : Double = 40.0
    @State private var opacity_0 : Double = 0.0
    
    @State private var padding_1 : Double = 40.0
    @State private var opacity_1 : Double = 0.0
    
    @State private var padding_2 : Double = 40.0
    @State private var opacity_2 : Double = 0.0
    
    @State private var padding_3 : Double = 40.0
    @State private var opacity_3 : Double = 0.0
    
    @State private var padding_4 : Double = 40.0
    @State private var opacity_4 : Double = 0.0
    
    @State private var padding_5 : Double = 40.0
    @State private var opacity_5 : Double = 0.0
    
    @State private var padding_6 : Double = 40.0
    @State private var opacity_6 : Double = 0.0
    
    
    func getScreenTimeText() -> String {
        var output : String = ""
        output = "Your Screentime Goal is " + formatDouble(model.screenTimeGoal) + " HOURS/DAY"
        return output
    }
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                HStack {
                    Text("Screen Time Goal")
                        .bold()
                        .foregroundColor(.white)
                        .font(.title2)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding(EdgeInsets(top: 32, leading: 0, bottom: 0, trailing: 0))
                
                ZStack {
                    RectangleSection(height: 180)
                    VStack {
                        HStack {
                            Image(systemName: "hourglass")
                                .symbolRenderingMode(.hierarchical)
                                .foregroundColor(.white)
                                .font(.system(size: 64))
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 16))
                            VStack {
                                HStack {
                                    Text(formatDouble(model.screenTimeGoal))
                                        .font(.system(.title3, design: .rounded))
                                        .foregroundColor(Color("DynamicYellow"))
                                        .bold()
                                        .multilineTextAlignment(.leading)
                                    Text((model.screenTimeGoal == 1 ? "HOUR / DAY" : "HOURS / DAY"))
                                        .bold()
                                        .foregroundColor(Color("DynamicYellow"))
                                        .font(.system(.title3, design: .rounded))
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                                Text(model.screenTimeGoal <= 2 ? "Bravo! With this goal, you're paving the way for a healthier and more balanced life. Be free from your phone!"
                                     : "Experts say adults should limit screen time outside of work to less than 2 hours/day. Be free from your phone!")
                                .foregroundColor(.white)
                                .font(.footnote)
                                .multilineTextAlignment(.leading)
                                Spacer()
                            }
                        }
                        .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
                        Button(action: {self.isScreenTimeGoalPresented.toggle()}) {
                            Rectangle()
                                .fill(Color(.secondarySystemGroupedBackground))
                                .opacity(0.5)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .cornerRadius(10)
                                .overlay(
                                    Text("Change your screen time goal")
                                        .foregroundColor(.white)
                                        .font(.subheadline)
                                        .bold()
                                , alignment: .center)
                                .padding(EdgeInsets(top: 0, leading: 16, bottom: 24, trailing: 16))
                        }
                        .sheet(isPresented: $isScreenTimeGoalPresented) {
                            // Create a sheet view to create a limit
                            ScreenTimeGoalSheetView(isDarkMode: $isDarkMode, goal: model.getScreenTimeGoal())
                                .environmentObject(BeeFreeModel.shared)
                                .environmentObject(store)
                        }
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 180)
                .padding(EdgeInsets(top: 6, leading: 0, bottom: 0, trailing: 0))
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 180)
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
            
            Button(action: {self.isDiscouragedPresented.toggle()}) {
                Rectangle()
                    .fill(Color("RedAccent"))
                    .frame(maxWidth: .infinity)
                    .frame(height: 64)
                    .cornerRadius(10.0)
                    .overlay(HStack {
                        Image(systemName: "lock.square")
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                        Text("Select apps to block")
                            .foregroundColor(.white)
                            .font(.subheadline)
                            .bold()
                    }, alignment: .center)
            }
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 10, trailing: 16))
            .familyActivityPicker(isPresented: $isDiscouragedPresented, selection: $model.selectionToDiscourage)
            .onChange(of: model.selectionToDiscourage) {
                BeeFreeModel.shared.setShieldRestrictions()
                //var summaryApps = SummarySet
            }
            
            HStack {
                Text("For You")
                    .bold()
                    .foregroundColor(.white)
                    .font(.title2)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 0))
            
            ZStack {
                RoundedRectangle(cornerRadius: 12.0)
                    .fill(Color("LighterSky"))
                    .frame(maxWidth: .infinity)
                    .frame(height: 232) // 270 - 290
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 66, trailing: 16))
                
                    VStack {
                        Label("BeeFree User Manual", systemImage: "info.circle")
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .foregroundColor(Color("WhyViolet"))
                            .background(Color(.secondarySystemGroupedBackground))
                            .cornerRadius(10.0)
                            .padding(EdgeInsets(top: 16, leading: padding_1, bottom: 0, trailing: 32))
                            .onTapGesture {
                                self.isUserManualPresented.toggle()
                            }
                            .sheet(isPresented: $isUserManualPresented) {
                                UserManualSheetView()
                            }
                        Link(destination: URL(string: "https://www.becomingminimalist.com/break-your-cell-phone-habit/")!) {
                            Label("Setting Healthy Phone Habits", systemImage: "apps.iphone")
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .foregroundColor(Color("WhyGreen"))
                                .background(Color(.secondarySystemGroupedBackground))
                                .opacity(opacity_2)
                                .cornerRadius(10.0)
                                .padding(EdgeInsets(top: 5, leading: padding_2, bottom: 0, trailing: 32))
                                .animation(.bouncy.delay(0.1 + delay), value: padding_2)
                                .animation(.easeIn.delay(0.1 + delay), value: opacity_2)
                        }
                        Link(destination: URL(string: "https://www.thegoodtrade.com/features/digital-detox-ideas/")!) {
                            Label("99 Ways To Not Use Your Phone", systemImage: "figure.walk")
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .foregroundColor(Color("WhyBlue"))
                                .background(Color(.secondarySystemGroupedBackground))
                                .opacity(opacity_3)
                                .cornerRadius(10.0)
                                .padding(EdgeInsets(top: 5, leading: padding_3, bottom: 0, trailing: 32))
                                .animation(.bouncy.delay(0.2 + delay), value: padding_3)
                                .animation(.easeIn.delay(0.2 + delay), value: opacity_3)
                        }
                        Link(destination: URL(string: "https://www.nhlbi.nih.gov/health/seducational/wecan/reduce-screen-time/index.htm")!) {
                            Label("NIH: Reduce Screen Time", systemImage: "clock.arrow.circlepath")
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .foregroundColor(Color("WhyOrange"))
                                .background(Color(.secondarySystemGroupedBackground))
                                .opacity(opacity_4)
                                .cornerRadius(10.0)
                                .padding(EdgeInsets(top: 5, leading: padding_4, bottom: 0, trailing: 32))
                                .animation(.bouncy.delay(0.3 + delay), value: padding_4)
                                .animation(.easeIn.delay(0.3 + delay), value: opacity_4)
                        }
//                        Link(destination: URL(string: "https://www.health.harvard.edu/healthbeat/safeguarding-your-sight#:~:text=Myth%3A%20Staring%20at%20a%20computer,harsh%20reflection%20on%20the%20screen.")!) {
//                            Label("Safeguard Your Sight", systemImage: "eye")
//                                .frame(maxWidth: .infinity)
//                                .frame(height: 40)
//                                .foregroundColor(Color("WhyYellow")) // Use appropriate color here
//                                .background(Color(.secondarySystemGroupedBackground))
//                                .opacity(opacity_5)
//                                .cornerRadius(10.0)
//                                .padding(EdgeInsets(top: 5, leading: padding_5, bottom: 0, trailing: 32))
//                                .animation(.bouncy.delay(0.4 + delay), value: padding_5)
//                                .animation(.easeIn.delay(0.4 + delay), value: opacity_5)
//                        }
//                        Link(destination: URL(string: "https://nymag.com/intelligencer/2023/08/a-better-way-to-think-about-young-kids-and-screen-time.html")!) {
//                            Label("Young Kids and Screen Time", systemImage: "figure.and.child.holdinghands")
//                                .frame(maxWidth: .infinity)
//                                .frame(height: 40)
//                                .foregroundColor(Color("WhyRed")) // Use appropriate color here
//                                .background(Color(.secondarySystemGroupedBackground))
//                                .opacity(opacity_6)
//                                .cornerRadius(10.0)
//                                .padding(EdgeInsets(top: 7, leading: padding_6, bottom: 60, trailing: 32))
//                                .animation(.bouncy.delay(0.5 + delay), value: padding_6)
//                                .animation(.easeIn.delay(0.5 + delay), value: opacity_6)
//                        }
                        Spacer() // Spacer to push buttons to the top
                    }
                    .onAppear {
                        padding_1 -= 8
                        opacity_1 += 1
                        
                        padding_2 -= 8
                        opacity_2 += 1
                        
                        padding_3 -= 8
                        opacity_3 += 1
                        
                        padding_4 -= 8
                        opacity_4 += 1
                        
                        padding_5 -= 8
                        opacity_5 += 1
                        
                        padding_6 -= 8
                        opacity_6 += 1
                    }
                    .onDisappear {
                        padding_1 += 8
                        opacity_1 -= 1
                        
                        padding_2 += 8
                        opacity_2 -= 1
                        
                        padding_3 += 8
                        opacity_3 -= 1
                        
                        padding_4 += 8
                        opacity_4 -= 1
                        
                        padding_5 += 8
                        opacity_5 -= 1
                        
                        padding_6 += 8
                        opacity_6 -= 1
                }
            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
        }
    }
}
