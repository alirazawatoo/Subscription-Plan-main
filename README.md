# Subscription-Plan

Introducing Subscription Plan: Your iOS app to subscribe to a particular plan. Crafted with Flutter, this app, built on the MVVM architecture, empowers you with to subscribe to Basic, Standard and Premium Subscriptions. Explore an array of features, get rates in different currencies with different durations and be notified with your plan expiration on the go.

## Demo Video
https://github.com/usmanasif/Subscription-Plan/assets/473630/d9aa8880-24f0-4845-b4d7-cf77335043da

## Requirements
Flutter & Dart

## Architecture

The app is built using the Model-View-ViewModel (MVVM) architecture pattern. Here's a brief overview of the different layers:

- Model: The data layer that represents the app's data and business logic. In this app, the models are the API Response and Subscriptions.
- View: The UI layer that displays the data to the user and handles user input. In this app, the views are implemented using Stacked Views which inturn use Provider.
- ViewModel: The glue layer that connects the view and the model. The view model handles the business logic and provides the data to the view. The viewmodel access the services such as API Service and Subscription Service.
- Services: Services are used to access other services. In this app, the api_service calls the dio_service.


## Usage

1. Clone the repository locally or use the template for your own projects:

2. Install dependencies using the following command:

```bash
flutter pub get
```

3. Generate files with `build_runner`:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. Run the app on your emulator of choice (simulator in case of iOS):

```
flutter run
```

## Folder Structure

```
lib/
|- api/
|- app/
|- constants/
|- enums/
|- exceptions/
|- models/
|- services
|- ui
  |- [screen_name]/
  |- shared/
|- utils
|- main.dart
```


## Custom Features
- Custom dialogs added to make user experience seemless.
- Error handling to handle exceptions in case of API failure.
- db.json file contains the JSON Data that is being fetched from mocki.io server.
- Refresh handlers to call the API.
- FontAwesome and Ionicons added to the subscriptions.
- Built in navigation service. No custom handlers required.



