# Overview

## System Architecture
![beefreesysarch3 0](https://github.com/ucsb-cs148-w24/project-pj12-appblocker/assets/52797797/2e03249b-8b85-4a85-b0e7-4c96defe9d84)


The **Apple API** is a central component to our app. We call the API in order for the user to be able to select apps they'd like to block. In return, the API provides us information and allows **our app** to generate reports of their screentime. On the app, we connect to Firebase to allow users to login. **Firebase** will check with GoogleAuth to see if the email is a valid Google account. If so, Firebase generates a unique UserID. If the user is new, they will be prompted to enter their preferred display name. Upon submission, the unique UserID will stored in **Firestore** along with their email, first name, and empty friends list. If they are a returning user, we fetch the information from **Firestore** through their UserID, and they are allowed to login and view the rest of the app. 

## Team Decisions
During the first weeks(lecture 2 in particular) of our project development, we explored many tech stack options to determine which one would work best for our App Blocker idea. We decided to use SwiftUI as there was a large amount of documentation regarding ScreenTimeAPI that we could use. The next step was to determine what back-end API to use. The team decided on Firebase, as it was the most beginner friendly and widely documented framework that would allow us easy access and implementation of login features and user data storage. The decision and setup was made during sprint02 during our 1/20/2024 daily scrum.

The next step included distributing out tasks to each member, with Peter and Mike focusing on Firebase login features for both front-end and back-end. Karan was tasked with many UI/UX tasks alongside research on Apple's ScreenTimeAPI, and Sunhu, Anushka, and Kavi worked on summary page implementation. Mujia was tasked with dealing with user inputs, particularly with time limits for apps. This decision was also made during our 1/20/2024 daily scrum.

During the MVP creation process, roles were assigned regarding voiceovers for the video presentation and finalizing documentation on our first MVP. The team discussed what functions could be included in the MVP and what needed more time to be developed. This all occurred during sprint03 from lecture06 to lecture08.

As of our most recent meetings, we have been discussing what to continue working on and what to cut, especially regarding ScreenTimeAPI for our summary page which has been causing many difficulties. Our most recent daily scrum as of the time of this writing has been 2/24/2024.
## UX + UserFlow
Our team wanted to make BeeFree as intuitive as possible so new users who are on the fence can easily navigate through our app and immediately get a good feel and understanding of how things work. We chose to have 3 quickly accessible tabs; the home page, the summary page, and the sharing page that each clearly define their puproses. A user flow below shows how the app works:
https://www.figma.com/proto/ODOuk0ZjYnNDZBpqao3gnA/UXFlow---BeeFree?type=design&node-id=5-22&t=B7cAUpqWfCNJYXXq-1&scaling=scale-down&page-id=0%3A1&starting-point-node-id=5%3A22&show-proto-sidebar=1&mode=design

This Figma flow shows the basic UX tasks a user would go through. It leads them from the welcome page to the login page, where they can select a Google account to login with. From there they can update their blocked apps and dailyscreentime limit. they can also view their summary, which displays their top apps and screentime usage for the day. The sharing page allows them to add and delete friends using their email. We also have a profile page where they can view their username and email, change privacy and notification setttings, and switch between dark mode and light mode
