# PROG8470-IOS-Lab8-Weather-API

Lab8 SPA project of PROG8470 IOS development of Conestoga College. This app uses GPS to simulate location, and use the location to generate http request and send to OpenWeather, after getting the json response, use it to set view of screen.

## Running Result

![](doc/images/2023-07-14-18-46-42-image.png)

## Set GPS delegate

use extension this time. This time to simulate location should use none or custom location.

![](doc/images/2023-07-14-18-54-27-image.png)

![](doc/images/2023-07-14-18-49-39-image.png)

## Prepare API params

The new API is a computed property, it consist of latitude, longtitude and api key

![](doc/images/2023-07-14-18-55-56-image.png)

## Send request and Decode json

datatask will execute the code asynchronously. weather property has set didSet, every time it is changed, it will set the UIViews.

![](doc/images/2023-07-14-18-58-45-image.png)

![](doc/images/2023-07-14-19-02-22-image.png)
