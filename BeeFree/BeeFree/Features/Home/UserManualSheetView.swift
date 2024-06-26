//
//  UserManualSheetView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 3/15/24.
//

import SwiftUI

struct UserManualSheetView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Text("BeeFree User Manual")
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
            ScrollView {
                Text("Our purpose")
                    .bold()
                    .font(.headline)
                    .padding(EdgeInsets(top: 32, leading: 16, bottom: 0, trailing: 16))
                
                Text("BeeFree's purpose is to provide those with phone addictions an easy way to keep track of their screen time usage and block applications they believe are most distracting to them. Users don't have to fight their addictions alone but can share their progress and challenges with family and friends to continue to motivate them. It's a simple app that provides intuitive features so anyone can quickly download the app and get started on their new journey of being addiction-free.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 4, leading: 16, bottom: 0, trailing: 16))
                
                Text("Intended User Audience")
                    .bold()
                    .font(.headline)
                    .padding(EdgeInsets(top: 32, leading: 16, bottom: 0, trailing: 16))
                
                Text("BeeFree is an app that is largely catered towards, but not limited to, those with phone and screen time addictions. Anyone can use the app if they want to keep track of their screen time information and/or want to share their information with others. Anyone who has a desire to keep themselves in check and wants to improve their productivity by spending time off their phones is warmly welcome to try our app.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 4, leading: 16, bottom: 0, trailing: 16))
                
                Text("Features")
                    .bold()
                    .font(.headline)
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
                
                Text("Our application has many features, but these are the main ones that we feel make our application important and stand out.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 4, leading: 16, bottom: 0, trailing: 16))
                
                // Feature 1: Accounts
                Text("Accounts")
                    .bold()
                    .font(.headline)
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
                
                Text("Users can create new accounts and log into existing ones so they can store their information, which largely comes into play for our sharing and friends function. The app first opens up a permissions notification that asks you to confirm that BeeFree is allowed access to your screen time information. Click continue, and you will be asked to input your passcode to confirm you are okay with giving BeeFree screentime permissions. Once complete, the user is redirected to a sign-in page where users can sign in via Google account. If the user already has an account with BeeFree they will immediately be redirected after signing in to their home page. Otherwise, the user must create an account and input a username for their new account.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 4, leading: 16, bottom: 0, trailing: 16))
                
                // Feature 2: App Blocking
                Text("App Blocking")
                    .bold()
                    .font(.headline)
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
                
                Text("One of the most important features of BeeFree. To block apps, navigate to the home page (which is opened by default after logging in) and press the red button that says \"select app to block\" at the middle of your page. Users can select apps of certain categories, such as Games or Entertainment, to restrict from use. They also have the option of blocking an entire category of apps. If the user tries to open the app, they will see that the app is grayed out and a screen will open up to the user saying that the app is unable to be opened. Users can choose to unblock the app whenever they desire. To do this, press on the same lock button that was used to block apps, and un-select the apps that were first selected to be blocked.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 4, leading: 16, bottom: 0, trailing: 16))
                
                // Feature 3: Summary Page
                Text("Summary Page")
                    .bold()
                    .font(.headline)
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
                
                Text("Users can see their total activity report and the top 5 apps they have used the most. At the top left of the page is a circle chart that changes colors as you get closer to the screen time goal the user chose. Users can use this information to determine what apps they should focus on for their addiction-freeing journey. The screen time goal can be set by users on the homepage on the \"Change your screen time goal\" button, above the \"Select apps to block\" button.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 4, leading: 16, bottom: 0, trailing: 16))
                
                // Feature 4: Sharing Page
                Text("Sharing Page")
                    .bold()
                    .font(.headline)
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
                
                Text("Users can set their total screen time given by their summary page (in hours and minutes), which will then be shared with their list of friends. To do this, navigate to the Sharing page and press the \"Update Your Screen Time\" button at the bottom. You will be redirected to a new page that allows you to adjust your screen time information that you wish to publicize to your friends. Go ahead and press \"Save and View Friends\" to view your friends' screen time information.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 4, leading: 16, bottom: 0, trailing: 16))
                
                // Feature 5: Home Page
                Text("Home Page")
                    .bold()
                    .font(.headline)
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
                
                Text("Besides the aforementioned app blocking and screen time goal settings, the Home Page also offers users a helpful list of trusty links that can aid users on managing their screen time.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 4, leading: 16, bottom: 0, trailing: 16))
            }
            Spacer()
        }
    }
}
