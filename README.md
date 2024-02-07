# App Blocker

Kaveri Iyer: iyerkaveri \
Karankumar Mageswaran: mageswarankk \
Ziming Wang: MikeW1121 \
Anushka Vijay: anushkavijay \
Mujia Chen: mujiaaa \
Peter Liang: hongye-liang \
Sunhu Choi: SunhuChoi 

## Application Description 
Our app allows you to choose, from the apps you have downloaded, what apps you would like to set a limit on. This limit is imposed on a per-day basis. You will be able to login and create an account using Google Authentication. On your home page you will see a partially-filled progress circle for each app you have chosen to block, which shows the percent of your target time that you have used up. You can also choose one app's status that you want to share with your friends. On the friends page, you will be able to see how much your friends have used of their app of choice. There will also be a settings page to change things like notification allowances and appearance. Users have the option to not join groups so they can just track their own app usage and block apps. 

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
