# Overview

## System Architecture
![beefreesysarch3 0](https://github.com/ucsb-cs148-w24/project-pj12-appblocker/assets/52797797/2e03249b-8b85-4a85-b0e7-4c96defe9d84)


The **Apple API** is a central component to our app. We call the API in order for the user to be able to select apps they'd like to block. In return, the API provides us information and allows **our app** to generate reports of their screentime. On the app, we connect to Firebase to allow users to login. **Firebase** will check with GoogleAuth to see if the email is a valid Google account. If so, Firebase generates a unique UserID. If the user is new, they will be prompted to enter their preferred display name. Upon submission, the unique UserID will stored in **Firestore** along with their email, first name, and empty friends list. If they are a returning user, we fetch the information from **Firestore** through their UserID, and they are allowed to login and view the rest of the app. 

## Team Decisions
During the first weeks(lecture 2 in particular) of our project development, we explored many tech stack options to determine which one would work best for our App Blocker idea. We decided to use SwiftUI as there was a large amount of documentation regarding ScreenTimeAPI that we could use. The next step was to determine what back-end API to use. The team decided on Firebase, as it was the most beginner friendly and widely documented framework that would allow us easy access and implementation of login features and user data storage. The decision and setup was made during sprint02 during our 1/20/2024 daily scrum.

The next step included distributing out tasks to each member, with Peter and Mike focusing on Firebase login features for both front-end and back-end. Karan was tasked with many UI/UX tasks alongside research on Apple's ScreenTimeAPI, and Sunhu, Anushka, and Kavi worked on summary page implementation. Mujia was tasked with dealing with user inputs, particularly with time limits for apps. This decision was also made during our 1/20/2024 daily scrum.

Our first Retrospective on 1/24/2024, we went over the initial weeks of progress that we had gone through and emphasizing a goal of ensuring proper documentation whenever team members work on the project on their own or with a partner but not with the entirety of the team. The team also focused on ensuring everyone had a strong understanding of branching and the use of the Kanban Board and what issues to work on in the coming weeks. 

During the MVP creation process, roles were assigned regarding voiceovers for the video presentation and finalizing documentation on our first MVP. The team discussed what functions could be included in the MVP and what needed more time to be developed. This all occurred during sprint03 from lecture06 to lecture08.

Our second Retrospective on 2/16/2024, we reviewed the results of our first Code Freeze and MVP, congratulating everyone on the work they have worked on. For future goals and what to work on, the team agreed that better accountability and communication was needed if any member was not sure they would make it to a meeting, lecture, or section. The team also boiled down on what features should be cut and what can be done in the last upcoming weeks. 

During our 2/24/2024 meeting, we discussed on what to continue working on and what needed to be cut, especially regarding ScreenTimeAPI for our summary page which has been causing many difficulties. 

The following meetings and lectures largely focused on working on Apple's ScreenTimeAPI to get the main summary view functionality working. Anushka and Karan largely worked on this aspect of the app. Before the 3rd Retrospective, Anushka and Karan managed to get much of the ScreenTimeAPI working that now provides a summary page.

In the 3rd and final retrospective on 3/6/2024, the team once again looked back on the current progress, what should be focused on, and what should be scrapped. The team agreed to conclude any issues that required the use of ScreenTimeAPI and focus on UI and other functionalities, such as sharing, that do not require any API usage that would be too risky to use given only about a week and a half of time remaining.

In our final Monday meeting at 7:30 PM 3/11/2024, the team split into 3 groups, one working on UI in our login and default entrance page, another working on adding home page funcionality, and the last group finishing up the sharing page. 

On 3/15, the team finalized all features and UI/UX of the app and posted the final app on GitHub.

## Coding Process
The first Kanban Board issues that we created were setting up login functionalities via Firebase in our app. Initially, the issue focused on both Google and Apple ID authentication, but overtime the acceptance criteria changed so only Google authentication needed to be implemented. We also had many of our main app functionalities as issues on the Kanban board, such as summary page setup, app limit storing, and creating app blocking. Any issues that needed database access were blocked under a Firestore issue that was set up by Sunhu and Peter. The issue regarding skeleton code for the Swift app that contained simple UI was the first major issue to be completed. 

Overtime we realized a lot of our issues were difficult or impossible to complete, leaving to a graveyard of issues, such as a very early issue that focused on storing app limit information into a database. To see the compromises we made, many issues under Peter and Mujia show the workaround we had to do, such as just asking the user for input on their screentime usage instead of relying on the ScreenTimeAPI to do it for us. Other issues relying on ScreenTimeAPI needed to be retconned to better match our discoveries and research overtime during the Code Process 

Issues towards the beginning of the coding process did not have many clear acceptance criteria, but many did have explcit connections to User Stories. Overtime, we began to add acceptance criteria to each of our issues as well. 

We made sure to connect almost every PR we make to a specific issue in our Kanban board so team members could easily determine what the team member was working on. Explanations in PR messages were clear and simple, as well as commit messages which appropriately and explicity described the main changes the team members made. 
## UX + UserFlow
Our team wanted to make BeeFree as intuitive as possible so new users who are on the fence can easily navigate through our app and immediately get a good feel and understanding of how things work. We chose to have 3 quickly accessible tabs; the home page, the summary page, and the sharing page that each clearly define their puproses. A user flow below shows how the app works:
https://www.figma.com/proto/ODOuk0ZjYnNDZBpqao3gnA/UXFlow---BeeFree?type=design&node-id=5-22&t=B7cAUpqWfCNJYXXq-1&scaling=scale-down&page-id=0%3A1&starting-point-node-id=5%3A22&show-proto-sidebar=1&mode=design

This Figma flow shows the basic UX tasks a user would go through. It leads them from the welcome page to the login page, where they can select a Google account to login with. From there they can update their blocked apps and dailyscreentime limit. they can also view their summary, which displays their top apps and screentime usage for the day. The sharing page allows them to add and delete friends using their email. We also have a profile page where they can view their username and email, change privacy and notification setttings, and switch between dark mode and light mode

