### Sunhu Choi: 
- Worked on much of the documentation for the project, creating user manual, deployment, presentations, and more
- Worked alongside Anushka and Peter to pair program to implement Apple's ScreenTimeAPI and backend Firebase storage
- Voiced and co-scripted final project video lines
- Led Retrospective 3

### Kaveri Iyer: 
I think my contributions graph is not necessarily indicative of my actual contributions to the codebase. For some of my listed contributions, I was actually a reviewer, and not the person who made the code changes. This is shown in commits such as https://github.com/ucsb-cs148-w24/project-pj12-appblocker/commit/aac0a37bafe20796ad5386cf442d3bc562bdf395. My main tasks on the team was documenting meetings and leading the UX/UI decisions. Mujia and I worked together on the initial mockup, and I took over for the MVP as well as the User Flow. 
I consistently kept our figma mockup up to date, and created design guidelines through that. I also did quite a bit of pair programming with Anushka and Karan throughout the summary page development process. Thus I do not have many lines of code added in my name, though I do have several commits of sprint documentation updates.

### Anushka Vijay: 
- Worked on a massive part of the ScreenTimeAPI of the app
- Helped monitor and set up the Kanban Board, setting up, creating, and assigning issues to team members
- Worked alongside Karan to get a majority of the features of the app completed
- Helped format, organize, and render the summary page
- Changed up the home page by adding helpful links and organized buttons 

### Mike Wang:
The contribution graph on the GitHub repo is not very accurate. GitHub gives the credit to the person who merges the changes rather than who writes and commits the code, so I think it's easier to ignore the graph and explain it here. For this project, I mainly worked on 4 different parts. First I helped everyone set up xcode and clone the github repo because the process is very different and a little confusing. Then I mainly worked on the login page. I first followed the firebase documentations to setup logging in with google authentication, then added the welcome page where the user can swipe up and access the login page. Then I focused on testing, and wrote unit tests and integration tests for the login features. Lastly my job is to make sure the UI is consistant across the whole app.

### Peter Liang: 
Contributed to set up firestore database to hold user's information and connect it to our app. Created a sign in page to guide users to sign up with their username and store in database, also making sure unique username for each user. Connect users to the content view after a successful login. Finished add friend page to allow users to add and remove other users as friends by searching up their emails in the database. Improved user experience by making add/remove friends appears in both user's end. Updated profile page by fetching user's name and email and displaying in profile page. Worked on file userDB, LoginView, addFriendView, TitleBarModifier.

### Mujia Chen: 
I implement a time selection feature which is used later in SharingView. I also implement the AddFriendView page with Peter (I coded the swift file and he works on the backend stuff). I implement the SharingView so that users can enter their total screen time and this jumps to FriendView which I'm doing right row.
And I adjust the background color for these files to make UI consistent.

### Karankumar Mageswaran:
I worked on the code skeleton, which were mainly the tabs, title bar, and background colors for both the day and night modes of the app. 
I created the limit sheet view, the fuctionality that allows you to select and block apps, making it block with device activity monitor (beefree model and beefree schedule). The dark mode/light mode was buggy at first, but I managed to recently get it working again. Anushka and I worked alongside eachother to make the summary page show screentime with device activity report from Apple's ScreenTimeAPI. Currently, it shows the top 5 apps. I also added a function that allows users to select their screen time goals, which are then reflected on a pi chart that changes colors depending on how close the user is to passing their screen time limit. 

### Summary of Additional Work up to BeeFree's official completion on 3/18/2024
- Both Anushka and Karan continued to work on ScreenTimeAPI, changing the Summary page features by providing more functionality with a new "pick up" feature that displays to users how many times they opened up the app. Karan also worked on animations to make the app look and feel more smooth. 
- Mujia and Peter both worked on the Sharing feature more, polishing the page and adjusting functionality to show a user their friend's screentime information via a pie chart
- Mike and Kavi worked on polishing the BeeFree's UI, making it look both consistent and clean. The color scheme of the app was made consistent. Both of them worked to change the login page design and add our BeeFree logo to it. Kavi also helped to create the final BeeFree app video, which was displayed to the rest of the class.
- Sunhu worked on creating the presentation and polishing up all the documentation needed for the app. He helped create the script and voiced all the lines in the video, which was later edited together by Kavi. 

I'd like to give a special congratulations to all teammates who worked on this project, everyone worked really hard and did everything in the best of their abilities!
