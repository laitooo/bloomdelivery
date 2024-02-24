# BloomDelivery

This project was build for the pupose of job assignment in 4 days.

A simple delivery app built in Flutter (Dart).
* The project separates the data logic from the UI logic and uses Provider as a middle-man.
* The project also uses Provider for a state manager.
* The app implements light and night mode.
* The project was developed for the sake of an assessment for joining the Bloom Techno team.

## Features:

* Implement interactive map views for users to select pickup and drop-off locations.
* Integrate location services to automatically fetch and display the user’s current location.
* Allow users to manually move a pin to adjust the pickup location.
* Allow users to search for the place by name using google's Places API.
* Enable users to add multiple stops to their delivery route.
* Update the route and estimated delivery information in real-time as stops are added or removed.
* Create a form to collect the receiver's details: name, contact number, and delivery instructions.
* Display available delivery options with estimated costs.
* Let users select their preferred delivery type and confirm the details.
* Present a list of goods types for users to choose from for the delivery.
* Ensure the selection updates the delivery details accordingly.
* Summarize all chosen details for final user confirmation.

## UI

The UI Design can be found at [Uizard](https://app.uizard.io/p/f977280a/overview)

## Gif screenshot

![Gif screenshot](https://github.com/laitooo/bloomdelivery/blob/main/screenshots/video.gif)

## Screenshots

Home screen                | Selecting pickup, dropoff | Adding stops - 1          | Adding stops - 2
:-------------------------:|:---------------------------------------------------------------------------:|:---------------------------------------------------------------------------:|:-------------------------:
![](https://github.com/laitooo/bloomdelivery/blob/main/screenshots/1.png)| ![](https://github.com/laitooo/bloomdelivery/blob/main/screenshots/2.png) | ![](https://github.com/laitooo/bloomdelivery/blob/main/screenshots/3.png) |![](https://github.com/laitooo/bloomdelivery/blob/main/screenshots/4.png)|

Receiver information       | Delivery options          | Goods selection           |  Confirming order
:-------------------------:|:---------------------------------------------------------------------------:|:---------------------------------------------------------------------------:|:-------------------------:
![](https://github.com/laitooo/bloomdelivery/blob/main/screenshots/5.png)| ![](https://github.com/laitooo/bloomdelivery/blob/main/screenshots/6.png) | ![](https://github.com/laitooo/bloomdelivery/blob/main/screenshots/7.png) |![](https://github.com/laitooo/bloomdelivery/blob/main/screenshots/8.png)|

Creating order             | Search screen                                 
:-------------------------:|:----------------------------------------------------------------------------:
![](https://github.com/laitooo/bloomdelivery/blob/main/screenshots/9.png)| ![](https://github.com/laitooo/bloomdelivery/blob/main/screenshots/10.png)


## Getting started

To run the project do the following steps:

1- Clone the project.

2- run "flutter clean".

3- run "flutter pub get".

4- run "flutter pub run build_runner build".

5- Add your google map api key to 'android/src/app/main/AndroidManifest.xml'.

6- run the project.
