Project Name: Get Fit
Team Members: Ewin Zuo, Michael Lee
Dependencies: 
- Swift 5
- iOS 13.2
- Pods: Alamofire, Firebase

Special Instructions:
- You'll probably need to run pod init && pod install
- Upon opening the app give permission to HealthKit and allow notifications

General Notes:
- Local notifications are set to trigger at 12pm every day based on number of steps taken.
- Pedometer is set to increment the steps taken label on the home screen based on pedometer data provided by healthkit. However on simulator there is no way to programmatically trigger this


| **Feature**  | **Description**  | **Percentage**  |
|---|---|---|
| Home Screen  | First screen seen by the user. Contains quick access buttons for modifying health info | Ewin - 100% |
| Calender Screen | Page that facilitates access to data from past days | Ewin - 100% |
| Daily View Screen | A page that contains data specific to a certain day | Ewin - 100% |
| Profile Screen | A page that allows users to customize personal info | Michael - 100% |
| Settings Screen| A page that tallows users to configure settings such as dark mode, notifications, and data retention | Michael - 100% |
| Login Screen | The entry point to the app. Users can create an account using firebase authentication or login without one | Michael - 100%|
| Food/Fitness Screen | Allows users to input food intake and fitness activity | Ewin - 100% |
| Local Notifications | Sends the user notification at noon every day with step count progress updates | Michael - 100%|
| Core data | Allows app to maintain persistent, user-specific stocks based on current user | Ewin - 50%; Michael - 50%|
| Health Kit | Integrated Apple health kit to manage user health and fitness data | Ewin - 100% |
| User Score Tracking | Offers daily challenges to motivate users to earn points by completing fitness goals | Ewin - 100%; Michael - 100%|
| Firebase Authentication | Allows users to create accounts and facilitates authenticated login | Michael - 100% |
