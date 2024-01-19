//
//  ContentView.swift
//  helloworld_kaveri
//
//  Created by Kaveri Iyer on 1/18/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showMenu = false
    var body: some View {
        
        VStack {
            Text("Hello, world!")
            Text("")
            Button {
                showMenu.toggle()
            } label : {
                Text(showMenu ? "Close Menu":"Open Menu")
            }
        }.padding()
        
        if showMenu {
            Text("Profile")
            Text("Friends")
            Text("Settings")
        }
        
        
    }
}

#Preview {
    ContentView()
}
