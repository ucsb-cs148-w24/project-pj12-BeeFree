//
//  CreateLimitSheetView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.
//

import SwiftUI

struct CreateLimitSheetView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @Binding var isDarkMode: Bool
    @State private var hours: Int = 0
    @State private var minutes: Int = 0
    @State private var seconds: Int = 0
    @State private var savedTime: (hours: Int, minutes: Int, seconds: Int)?
    
    var body: some View {
        NavigationStack {
            VStack {
                // Title Stack
                ZStack {
                    HStack {
                        Text("Create App Limit")
                            .bold()
                            .font(.title2)
                            .padding(EdgeInsets(top: 32, leading: 16, bottom: 8, trailing: 16))
                    }
                    HStack {
                        Spacer()
                        Text("Done")
                            .onTapGesture {
                                dismiss()
                            }
                            .bold()
                            .font(.title3)
                            .foregroundColor(Color("AccentColor"))
                            .padding(EdgeInsets(top: 32, leading: 16, bottom: 8, trailing: 16))
                    }
                    
                }
                // Settings
                Form {
                    Section(header: Text("Set Time")) {
                        HStack{
                            Picker("Hours", selection: $hours) {
                                ForEach(0..<24, id: \.self) { hour in
                                    Text("\(hour) hr").tag(hour)
                                }
                            }
                            .pickerStyle(.wheel)
                            
                            Picker("Minutes", selection: $minutes) {
                                ForEach(0..<60, id: \.self) { minute in
                                    Text("\(minute) min").tag(minute)
                                }
                            }
                            .pickerStyle(.wheel)
                            
                            Picker("Seconds", selection: $seconds) {
                                ForEach(0..<60, id: \.self) { second in
                                    Text("\(second) sec").tag(second)
                                }
                            }
                            .pickerStyle(.wheel)
                        }
                        
                        Section {
                            Button("Save Time") {
                                saveTime()
                            }
                        }
                        
                        if let savedTime = savedTime {
                            Section(header: Text("Saved Time")) {
                                Text("\(savedTime.hours) hr \(savedTime.minutes) min \(savedTime.seconds) sec")
                            }
                        }
                    }
                }
                Spacer()
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .background(Color("Background").edgesIgnoringSafeArea(.all))
    }
    private func saveTime() {
        savedTime = (hours, minutes, seconds)
    }
}



#Preview {
    CreateLimitSheetView(isDarkMode: .constant(false))
}
