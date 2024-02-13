//
//  ExampleView.swift
//  BeeFree
//
//  Created by Anushka Vijay on 2/12/24.
//

import SwiftUI
import DeviceActivity
import ManagedSettings
import FamilyControls

struct ExampleView: View {
    @State var selection = FamilyActivitySelection()


    var body: some View {
        VStack {
            Image(systemName: "eye")
                .font(.system(size: 76.0))
                .padding()


            FamilyActivityPicker(selection: $selection)


            Image(systemName: "hourglass")
                .font(.system(size: 76.0))
                .padding()
        }
        .onChange(of: selection) { newSelection in
            let applications = selection.applications
            let categories = selection.categories
            let webDomains = selection.webDomains
        }
    }
}

#Preview {
    ExampleView()
}
