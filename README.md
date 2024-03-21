# App Blocker

Kaveri Iyer: iyerkaveri \
Karankumar Mageswaran: mageswarankk \
Ziming Wang: MikeW1121 \
Anushka Vijay: anushkavijay \
Mujia Chen: mujiaaa \
Peter Liang: hongye-liang \
Sunhu Choi: SunhuChoi 

## Application Description 
Our app allows you to choose, from the apps you have downloaded, what apps you would like to set a limit on. This limit is imposed on a per-day basis. Our app allows you to create an account via Google. Once in, you are greeted with a Home Page that allows you to block any app of your choice and set up a screentime goal. Our summary page shows you the top 5 apps that you have opened and the top 5 apps that you have used based on screentime. Our sharing feature, which sets us apart from other competition, allows you to connect with friends and see their screen time usage, which is inputed by the user. 

### User Roles:
Our app likely only has one kind of user, which is the general user of the app. Everyone using our app will have the same goal, blocking their app usage. 

### Permissions:
We are not currently planning on restricting our userbase to @ucsb.edu email addresses. Notifications will be optional.

### Tech Stack 
We have decided to use Swift to create an iOS mobile application. We will use Firebase and GoogleAuth for user login, and Firestore to store user information and data pertinent to the app. 

### Installation
## Prerequisites
Installation of this app requires Xcode 15.
## Dependencies
Firebase authentication and our login view required firebase-ios-sdk and Google-sign-in and sign-in-swift libraries. An apple developer account is required for most deployments to ios devices outside of the built-in simulator on Xcode.
## Installation Steps
Users can install the beta version of our app according to the instructions provided by Apple [here](https://developer.apple.com/documentation/xcode/distributing-your-app-to-registered-devices#Prepare-for-your-build). This requires downloading our codebase onto Xcode, registering an iPhone/iPad with Xcode, creating a .ipa file which can then be installed on a user's device and then the app will be ready to use! For deployment in this course, we will create this .ipa file for the final version of our app so that users can simply install using Xcode, attach their device on Xcode, and then select our file to install on their device.
## Functionality
To begin, you will be directed to accept or deny permissions required for the BeeFree app to manage app information and block apps from users. Then, you will be asked to log in via Google or you can create an account if you are new to the app. Once you have logged in or created an app, you will be directed to the home page where all the main functionalities exist. A navigation bar at the bottom allows you to move to other pages, such as your profile, summary, and app blocking pages. For now, BeeFree only contains a general outline of these functionalities, as the APIs have currently not been called yet for full functionality.
## Known Problems
After logging in, the home page currently displays a back button that allows the user to go back to the login page which should not be displayed.
## Deployment
Currently, deployment through the App Store and TestFlight are unavailable due to ScreenTimeAPI permissions. We will hopefully update this in the future!
