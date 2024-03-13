//
//  ScreenTimeGoalSheetView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 3/4/24.
//

import SwiftUI
import ManagedSettings
import DeviceActivity
import FamilyControls

struct ScreenTimeGoalSheetView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var isDarkMode : Bool
    @EnvironmentObject var store: ManagedSettingsStore
    @EnvironmentObject var model: BeeFreeModel
    
    @State var goal: Double
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Cancel")
                        .onTapGesture {
                            dismiss()
                        }
                        .bold()
                        .font(.title3)
                        .foregroundColor(Color("AccentColor"))
                        .padding(EdgeInsets(top: 32, leading: 16, bottom: 8, trailing: 16))
                    Spacer()
                }
                VStack{
                    Text("Your Screen Time Goal")
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
                    Text("Set a total screen time goal for your device.")
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 4, leading: 16, bottom: 0, trailing: 16))
                }
                Spacer()
                VStack {
                    ZStack{
                        HStack {
                            Image(systemName: "minus.circle.fill")
                                .resizable()
                                .foregroundColor((goal == 0 ? Color("AccentColor") : Color("AccentColor")))
                                .opacity((goal == 0 ? 0.5 : 1.0))
                                .frame(width: 50, height: 50)
                                .padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 0))
                                .onTapGesture {
                                    if (goal == 0) {}
                                    else {
                                        goal -= 0.5
                                    }
                                }
                            Spacer()
                        }
                        Text(String(formatDouble(goal)))
                            .bold()
                            .font(.system(size: 69, design: .rounded))
                            .padding(EdgeInsets(top: 0, leading: 64, bottom: 0, trailing: 64))
                        HStack {
                            Spacer()
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .foregroundColor((goal == 24 ? Color("AccentColor") : Color("AccentColor")))
                                .opacity((goal == 24 ? 0.5 : 1.0))
                                .frame(width: 50, height: 50)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32))
                                .onTapGesture {
                                    if (goal == 24) {}
                                    else {
                                        goal += (0.5.truncatingRemainder(dividingBy: 24))
                                    }
                                }
                        }
                    }
                    Text("HOURS / DAY")
                        .bold()
                        .font(.system(size: 20))
                }
                .frame(maxWidth: .infinity, maxHeight: 500)
                Spacer()
                
                
                
                Rectangle()
                    .fill(Color("ButtonGray"))
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .cornerRadius(16.0)
                    .overlay(HStack {
                        Text("Change your screen time goal")
                            .font(.subheadline)
                            .bold()
                    }, alignment: .center)
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 64, trailing: 16))
                    .onTapGesture {
                        model.setScreenTimeGoal(x: goal)
                        let defaults = UserDefaults(suiteName: "group.com.BeeFreeAppBlocker.mygroup")
                        let defaultValue = ["seconds" : model.getScreenTimeGoalSecs()]
                        defaults!.register(defaults: defaultValue)
                        defaults!.set(model.getScreenTimeGoalSecs(), forKey: "seconds")
                        defaults!.synchronize()
                        dismiss()
                    }
            }
        }
        .background(Color("Background").edgesIgnoringSafeArea(.all))
    }
    
    func formatDouble(_ value: Double) -> String {
        if value.truncatingRemainder(dividingBy: 1.0) == 0.0 {
            return String(format: "%.0f", value)
        } else {
            return String(value)
        }
    }
}
