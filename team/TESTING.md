# Testing Libraries
As we're using Swift in XCode, we don't have a lot of options as to what testing libraries we can use. From our research online and talking to instructors, we came to the conclusion that we would stick to using XCode's inbuilt XCTest framework. 

# Testing Approach
We're still exploring XCTest and it's capabilites, so for this week we really just wanted to get a basic test working. In order to accomplish this, we created a simple test that made sure the First Name that BeeFree users input is valid. We started with a simple math check of 5 == 5 to see if our test would run successfully, then once it did we adapted it to test the basic funcionality of name validity.  Validity is a simple check to make sure the first name does not include common curse words or other blacklisted words. 

# Unit Test Documentation
![image](https://github.com/ucsb-cs148-w24/project-pj12-appblocker/assets/52797797/de143467-c5ba-41ac-b347-33bb4db3b8dd)

# Unit Testing Approach Going Forward
We plan to continue using XCTest for future unit testing as that is the official testing framework for SwiftUI code. Despite it being rather complicated, it has been working sufficiently for our unit tests and the integration test that we mention below 

# Integration Testing 
We created a new XCTest to test our Firebase login integration to ensure that when the app is first launched and the user is prompted on whether they wish to create a new account or login with an existing Google account, that each component functions correctly. To do this, we created a mock function that creates a new user and checks that their email is added into a mock database. We also created a mock function that checks if the user already exists. As seen below in the XCTAssert under testLoginNewUser(), the test returns true because the simulation correctly added the email newuser@eaxmple.com. If we change the email in the XCTAssert, you can see that it will fail. This shows that the test is correctly checking to ensure our Firebase integration is working.
![image](https://github.com/ucsb-cs148-w24/project-pj12-appblocker/assets/91865075/ab10584e-2c31-4979-a7fb-17410cebdd86)
![image](https://github.com/ucsb-cs148-w24/project-pj12-appblocker/assets/91865075/0de71175-baa0-48f8-89fc-98279166b643)
![image](https://github.com/ucsb-cs148-w24/project-pj12-appblocker/assets/91865075/c704e6c2-9181-43b3-af43-84d2265b1179)
![image](https://github.com/ucsb-cs148-w24/project-pj12-appblocker/assets/91865075/401b871d-156e-41aa-87cb-794c65dc39f9)

# Our Plans For Higher-Level Testing Going Forward
While we have been using XCTest, we have also been trying to use Quick and Nimble for BDD going forward. Quick and Nimble on top of XCTest allows for us to do standard Gherkin BDD with Given,When,Then syntax via describe(), context(), and it() functions respectively. While we weren't able to fully execute on testing with Quick and Nimble, it is something we want to focus on in the future for higher-level testing.
