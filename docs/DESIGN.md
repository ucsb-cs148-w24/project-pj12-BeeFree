# Overview

## System Architecture
![beefreesysarch3 0](https://github.com/ucsb-cs148-w24/project-pj12-appblocker/assets/52797797/2e03249b-8b85-4a85-b0e7-4c96defe9d84)


The **Apple API** is a central component to our app. We call the API in order for the user to be able to select apps they'd like to block. In return, the API provides us information and allows **our app** to generate reports of their screentime. On the app, we connect to Firebase to allow users to login. **Firebase** will check with GoogleAuth to see if the email is a valid Google account. If so, Firebase generates a unique UserID. If the user is new, they will be prompted to enter their preferred display name. Upon submission, the unique UserID will stored in **Firestore** along with their email, first name, and empty friends list. If they are a returning user, we fetch the information from **Firestore** through their UserID, and they are allowed to login and view the rest of the app. 

## Team Decisions

## UX + UserFlow

