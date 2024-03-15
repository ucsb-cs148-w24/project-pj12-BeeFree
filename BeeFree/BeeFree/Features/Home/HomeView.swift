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
    
    
    func getScreenTimeText() -> String {
        var output : String = ""
        output = "Your Screentime Goal is " + formatDouble(model.screenTimeGoal) + " HOURS/DAY"
        return output
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Screen Time Goal")
                        .bold()
                        .foregroundColor(.white)
                        .font(.title2)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0))
                
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
                                    Text("HOURS / DAY")
                                        .bold()
                                        .foregroundColor(Color("DynamicYellow"))
                                        .font(.system(.title3, design: .rounded))
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                                Text(model.screenTimeGoal <= 2 ? "Bravo! With this goal, you're paving the way for a healthier and more balanced life. Be free from your phone!"
                                     : "Experts say adults should limit screen time outside of work to less than 2 hours/day. Be free from your phone!")
                                .foregroundColor(Color("DynamicGray"))
                                .font(.footnote)
                                .multilineTextAlignment(.leading)
                                Spacer()
                            }
                        }
                        .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
                        Button(action: {self.isScreenTimeGoalPresented.toggle()}) {
                            Rectangle()
                                .fill(Color("LighterSky"))
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .cornerRadius(12.0)
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
                    .cornerRadius(12.0)
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
            .padding(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
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
                UnevenRoundedRectangle()
                    .fill(Color("LighterSky"))
                    .frame(maxWidth: .infinity)
                    .frame(height: 290) // 270 - 290
                    .clipShape(
                        .rect(
                            topLeadingRadius: 12,
                            bottomLeadingRadius: 0,
                            bottomTrailingRadius: 0,
                            topTrailingRadius: 12
                        )
                    )
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                
                ScrollView {
                    VStack {
                        Link(destination: URL(string: "https://github.com/ucsb-cs148-w24/project-pj12-appblocker/blob/main/docs/MANUAL.md")!) {
                            Label("Bee Free User Manual", systemImage: "info.circle")
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .background(Color("WhyViolet"))
                                .foregroundColor(.white)
                                .cornerRadius(10.0)
                                .padding(EdgeInsets(top: 16, leading: 32, bottom: 0, trailing: 32))
                        }
                        Link(destination: URL(string: "https://www.becomingminimalist.com/break-your-cell-phone-habit/")!) {
                            Label("Setting Healthy Phone Habits", systemImage: "apps.iphone")
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .background(Color("WhyGreen"))
                                .foregroundColor(.white)
                                .cornerRadius(10.0)
                                .padding(EdgeInsets(top: 5, leading: 32, bottom: 0, trailing: 32))
                        }
                        Link(destination: URL(string: "https://www.thegoodtrade.com/features/digital-detox-ideas/")!) {
                            Label("99 Ways To Not Use Your Phone", systemImage: "figure.walk")
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .background(Color("WhyBlue"))
                                .foregroundColor(.white)
                                .cornerRadius(10.0)
                                .padding(EdgeInsets(top: 5, leading: 32, bottom: 0, trailing: 32))
                        }
                        Link(destination: URL(string: "https://www.nhlbi.nih.gov/health/educational/wecan/reduce-screen-time/index.htm")!) {
                            Label("NIH: Reduce Screen Time", systemImage: "clock.arrow.circlepath")
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .background(Color("WhyOrange"))
                                .foregroundColor(.white)
                                .cornerRadius(10.0)
                                .padding(EdgeInsets(top: 5, leading: 32, bottom: 0, trailing: 32))
                        }
                        Link(destination: URL(string: "https://www.health.harvard.edu/healthbeat/safeguarding-your-sight#:~:text=Myth%3A%20Staring%20at%20a%20computer,harsh%20reflection%20on%20the%20screen.")!) {
                            Label("Safeguard Your Sight", systemImage: "eye")
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .background(Color("WhyYellow")) // Use appropriate color here
                                .foregroundColor(.white)
                                .cornerRadius(10.0)
                                .padding(EdgeInsets(top: 5, leading: 32, bottom: 0, trailing: 32))
                        }
                        Link(destination: URL(string: "https://nymag.com/intelligencer/2023/08/a-better-way-to-think-about-young-kids-and-screen-time.html")!) {
                            Label("Young Kids and Screen Time", systemImage: "figure.and.child.holdinghands")
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .background(Color("WhyRed")) // Use appropriate color here
                                .foregroundColor(.white)
                                .cornerRadius(10.0)
                                .padding(EdgeInsets(top: 7, leading: 32, bottom: 80, trailing: 32))
                        }
                        Spacer() // Spacer to push buttons to the top
                    }
                }
            }
            
            Spacer()
            Spacer()
        }
    }
}
