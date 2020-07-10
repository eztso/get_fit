Project Name: Get Fit
Team Members: Ewin Zuo, Michael Lee
Dependencies: 
* Swift 5
* iOS 13.2
* Pods: Alamofire, Firebase

Frameworks Used:
* Health Kit
* Multithreading
* Local Notifications
* Firebase
* User Defaults
* Charts
* Core Data
* Calender (dates)

Special Instructions:
* You need to open the 'Get Fit.xcworkspace file'
* You'll probably need to run pod init && pod install in the root directory where the pod file is located
* Use an IPhone 11 Pro Max simulator
* Upon opening the app give permission to HealthKit and allow notifications
* You can create an account or log in as guest. All guest data is shared across sessions with other guests.
    * If you don't want to create an account you can use this test account
    * Email: test@test.com
    * Pw: testing

General Notes:
* Local notifications are set to trigger at 12pm every day with different messages based on number of steps taken (if notifications are enabled).
* Pedometer is set to increment the steps taken label on the home screen based on pedometer data provided by healthkit. However on simulator there is no way to programmatically trigger this. You can load the app on your actual phone to see this in action
* Settings page details: Notifications - enables/disables notifications, Dark mode - enables/disables dark mode, Data retention - if disabled we will delete the user's data after 90 days
* All health data is stored using core data and is associated with a specific user account
* On our first daily view controller with the charts, you can scroll down slightly to see the button to the next view controller

Changes From Proposal:
* We found that having a grid-style calender view was very difficult to working due to the number of edge cases and day layout. Ultimately we compromised to retain the ability to access all past days by instead implementing the calender as a scrolling table of dates sorted in chronological order.

| **Feature**  | **Description**  | **Percentage**  |
|---|---|---|
| Home Screen  | First screen seen by the user. Contains quick access buttons for modifying health info | Ewin - 100% |
| Calender Screen | Page that facilitates access to data from past days | Ewin - 100% |
| Daily View Screen | A page that contains data specific to a certain day with charts and visualizations | Ewin - 100% |
| Metrics Screen | A page that contains aggregated visualizations detailing a user's progress over time | Ewin - 100% |
| Profile Screen | A page that allows users to customize personal info | Michael - 100% |
| Settings Screen| A page that tallows users to configure settings such as dark mode, notifications, and data retention | Michael - 100% |
| Login Screen | The entry point to the app. Users can create an account using firebase authentication or login without one | Michael - 100%|
| Food/Fitness Screen | Allows users to input food intake and fitness activity | Ewin - 100% |
| Local Notifications | Sends the user notification at noon every day with step count progress updates | Michael - 100%|
| Core data | Allows app to maintain persistent, user-specific stocks based on current user | Ewin - 50%; Michael - 50%|
| Health Kit | Integrated Apple health kit to manage user health and fitness data | Ewin - 100% |
| User Score Tracking | Offers daily challenges to motivate users to earn points by completing fitness goals | Ewin - 100%; Michael - 100%|
| Firebase Authentication | Allows users to create accounts and facilitates authenticated login | Michael - 100% |
| Profile Image Uploading | Allows each user to upload their own profile picture for increased personalization | Michael - 100%|
| Fitness Challenges | Issues up to 3 daily challenges to motivate users to earn points by completing fitness related tasks | Ewin - 100% |
| Step Counter | A step counter utilizing health kit pedometer that tracks your progress towards your daily step goals | Ewin - 100% |
