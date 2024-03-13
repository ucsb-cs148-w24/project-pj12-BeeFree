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

struct HomeView: View {
    @Binding var isDarkMode : Bool
    @Binding var set: [String]
    @EnvironmentObject var store: ManagedSettingsStore
    @EnvironmentObject var model: BeeFreeModel
    @State var selection = FamilyActivitySelection()
    
    @State private var isScreenTimeGoalPresented = false
    @State private var isDiscouragedPresented = false
    
    var body: some View {
        VStack{
            HStack {
                VStack {
                    Text("Your Screentime Goal is")
                        .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                        .bold()
                        .foregroundColor(Color("DynamicGray"))
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                    HStack {
                        Text(formatDouble(model.screenTimeGoal))
                            .font(.system(size: 48, design: .rounded))
                            .foregroundColor(.white)
                            .bold()
                            .multilineTextAlignment(.leading)
                        VStack{
                            Spacer()
                            Text("HOURS / DAY")
                                .bold()
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                                .multilineTextAlignment(.leading)
                        }
                    }
                    Spacer()
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .padding()
            Spacer()
            Spacer()
            Button(action: {self.isDiscouragedPresented.toggle()}) {
                Rectangle()
                    .fill(Color("LighterSky"))
                    .frame(maxWidth: .infinity)
                    .frame(height: 64)
                    .cornerRadius(16.0)
                    .overlay(HStack {
                        Image(systemName: "lock.square")
                            .foregroundColor(Color("RedAccent"))
                        Text("Select apps to block")
                            .foregroundColor(Color("RedAccent"))
                            .font(.subheadline)
                            .bold()
                    }, alignment: .center)
            }
            .familyActivityPicker(isPresented: $isDiscouragedPresented, selection: $model.selectionToDiscourage)
            .onChange(of: model.selectionToDiscourage) {
                BeeFreeModel.shared.setShieldRestrictions()
                //var summaryApps = SummarySet
            }
            Button(action: {self.isScreenTimeGoalPresented.toggle()}) {
                Rectangle()
                    .fill(Color("LighterSky"))
                    .frame(maxWidth: .infinity)
                    .frame(height: 64)
                    .cornerRadius(16.0)
                    .overlay(HStack {
                        Image(systemName: "hourglass")
                            .foregroundColor(Color("DynamicGray"))
                        Text("Change your screen time goal")
                            .foregroundColor(Color("DynamicGray"))
                            .font(.subheadline)
                            .bold()
                    }, alignment: .center)
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 76, trailing: 16))
            }
            
            .sheet(isPresented: $isScreenTimeGoalPresented) {
                // Create a sheet view to create a limit
                ScreenTimeGoalSheetView(isDarkMode: $isDarkMode, goal: model.getScreenTimeGoal())
                    .environmentObject(BeeFreeModel.shared)
                    .environmentObject(store)
            }
        }
    }
    func formatDouble(_ value: Double) -> String {
        if value.truncatingRemainder(dividingBy: 1.0) == 0.0 {
            return String(format: "%.0f", value)
        } else {
            return String(value)
        }
    }
}
