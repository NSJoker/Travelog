# Travelog

This is a travel logging app.
Imagine you’re traveling to a new city. Instead of keeping a journal, this app will automatically track locations you visit, so you can remember them later and compare them with your friends.

## How to run
Open the application in **Xcode 12.5** or later. ***To test the full extent of the app please run in a simulator.*** The app uses **Swift Package Manager** to access Firebase and Crashlytics.

## Usage
when you are using a simulator, in the Appdelegate file, make sure to call
```
LocationServicesManager.shared.startFetchingLocations(isFake: true)
```
This will help you simulate fake locations. If you are using an iPhone or iPad to test the application, pass the parameter isFake as false.

Once the app runs in your simulator, provide the necessary permissions for location services and user notifications.

I have added *Route.gpx* file to the project to simulate the locations.To use it. Once you have given the permissions, in your Xcode's debug area, click the simulate location icon and then select **"Route"** from the list. Minimize or kill the app to start observing the notifications. You can also observe the location information in the Visit logs screen. 

### On a real device
Before running the app on a real device. Make sure that you have the code set like the following in the Appdelegate.

```
LocationServicesManager.shared.startFetchingLocations(isFake: false)
```

The app will keep track of every new visit location. **The app will work even if the app is killed or it is in the background.**

### What app tracks when run on a simulator
Before running the app on a simulator. Make sure that you have the code set like the following in the Appdelegate.

```
LocationServicesManager.shared.startFetchingLocations(isFake: true)
```
The app will track the locations I have set in the Route.gpx file. **The app will work only if the Xcode is running the app on its simulator in debug mode. The app will not work if the app is killed.**

## App Architecture

The application uses the following concepts on a very high-level
- **MVVM** architecture
- **Coordinators** for navigation
- **Protocol oriented programming**
- UI extensions for reusable codes

## Issues
- In case when you uninstall and then reinstall the app, if the app doesn't ask again for location permission(doesn't show the ui for this). Then Kindly change the bundle ID to a different one and run again. 
- Since we are accessing the location services always, the app will drain the device battery fast. We need to optimise this.

## Support
- The app supports both **normal** and **dark** modes of the device. 
- The app supports both (all)iPhone and (all)iPad screen sizes.

## How to see crashes?
The app uses a personal project of the developer in the firebase. The tester can create a new project in firebase and replace the ***GoogleService-Info.plist*** with their own and start testing for crashes. The crashes will start appearing in tester's Crashlytics dashboard after this. The tester may have to upload a dysm file to porperly analyse the crash report.
