# BloomDelivery

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

## Dependencies
<details>
     <summary> Click to expand </summary>

* [flutter_bloc](https://pub.dev/packages/flutter_bloc)
* [shared_preferences](https://pub.dev/packages/shared_preferences)
* [flutter_svg](https://pub.dev/packages/flutter_svg)
* [get_it](https://pub.dev/packages/get_it)
* [paginated_live_list](https://github.com/AkramIzz/paginated_live_list)
* [percent_indicator](https://pub.dev/packages/percent_indicator)
* [flutter_rating_bar](https://pub.dev/packages/flutter_rating_bar)
* [syncfusion_flutter_sliders](https://pub.dev/packages/syncfusion_flutter_sliders)
* [country_picker](https://pub.dev/packages/country_picker)
* [fast_i18n](https://pub.dev/packages/fast_i18n)
* [build_runner](https://pub.dev/packages/build_runner)
* [json_serializable](https://pub.dev/packages/json_serializable)
* [freezed](https://pub.dev/packages/freezed)

</details>

## Screenshots

Home screen                | Selecting pickup, dropoff | Adding stops - 1          | Adding stops - 2
:-------------------------:|:---------------------------------------------------------------------------:|:---------------------------------------------------------------------------:|:-------------------------:
![](https://github.com/laitooo/bloomdelivery/blob/master/screenshots/1.jpg)| ![](https://github.com/laitooo/bloomdelivery/blob/master/screenshots/2.jpg) | ![](https://github.com/laitooo/bloomdelivery/blob/master/screenshots/3.jpg) |![](https://github.com/laitooo/bloomdelivery/blob/master/screenshots/4.jpg)|

Receiver information       | Delivery options          | Goods selection           |  Confirming order
:-------------------------:|:---------------------------------------------------------------------------:|:---------------------------------------------------------------------------:|:-------------------------:
![](https://github.com/laitooo/bloomdelivery/blob/master/screenshots/5.jpg)| ![](https://github.com/laitooo/bloomdelivery/blob/master/screenshots/6.jpg) | ![](https://github.com/laitooo/bloomdelivery/blob/master/screenshots/7.jpg) |![](https://github.com/laitooo/bloomdelivery/blob/master/screenshots/8.jpg)|

Creating order             |                                Search screen                                 | Register screen - 5       | Home screen
:-------------------------:|:----------------------------------------------------------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/laitooo/bloomdelivery/blob/master/screenshots/9.jpg)| ![](https://github.com/laitooo/bloomdelivery/blob/master/screenshots/10.jpg) |![](https://github.com/laitooo/bibliotheque/blob/master/screenshots/11.jpg)|![](https://github.com/laitooo/bibliotheque/blob/master/screenshots/12.jpg)|


## Getting started

To run the project do the following steps:

1- Clone the project.

2- run "flutter clean".

3- run "flutter pub get".

4- run "flutter pub run build_runner build".

5- run the project.
