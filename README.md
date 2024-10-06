# E-Commerce App

## Overview

This is an e-commerce application built using Flutter, Firebase Authentication, Firebase Firestore, Firebase Remote Config, and an external API to fetch product data. The app features a user authentication system, a product feed displaying discounted prices based on a remote configuration flag, and a clean, responsive UI that follows the specified design guidelines.

## Features

- **Firebase Authentication**: Users can register and log in using their email addresses.
- **Firestore Integration**: User details (name and email) are stored securely in Firestore.
- **Product Feed**: Displays all products fetched from [DummyJSON](https://dummyjson.com/products).
- **Dynamic Pricing**: The app calculates and displays discounted prices based on the `discountPercentage` field from the API, controlled by a boolean flag in Firebase Remote Config.
- **Error Handling**: Proper error handling is implemented for API and Firebase interactions.
- **Form Validation**: Input fields for user registration include validation checks.
- **State Management**: Utilizes the Provider package for state management.

## Bonus Features

- **Product Filtering**: Users can filter products based on categories for a more tailored shopping experience.
- **Product Details Bottom Sheet**: Users can tap on a product to view detailed information, including reviews.
- **User Reviews**: Displays user reviews for each product to help users judge product quality.
- **MVVM Architecture**: The app follows the Model-View-ViewModel architecture pattern for better organization and separation of concerns.
  
## Technologies Used

- Flutter >= v2.2.0
- Firebase Authentication
- Firebase Firestore
- Firebase Remote Config
- Dart
- Provider for state management
- HTTP for API requests
- Google Fonts for UI styling

Certainly! Here’s the `Installation` section formatted in GitHub Markdown style:

```markdown
## Installation

1. **Clone the repository**:

   ```bash
   git clone https://github.com/yourusername/ecommerce-app.git
   cd ecommerce-app
   ```

2. **Install dependencies**:

   Make sure you have Flutter installed on your machine. Run the following command in the terminal:

   ```bash
   flutter pub get
   ```

3. **Set up Firebase**:

   - Create a Firebase project in the [Firebase Console](https://console.firebase.google.com/).
   - Enable Firebase Authentication and Firestore.
   - Set up Firebase Remote Config.
   - Download the `google-services.json` file and place it in the `android/app` directory.
   - Follow the Firebase documentation to configure your app for Firebase.

4. **Update your `pubspec.yaml`**:

   Ensure that you have the necessary dependencies in your `pubspec.yaml` file. Here’s an example of what it might look like:

   ```yaml
   dependencies:
     flutter:
       sdk: flutter
     firebase_core: ^2.0.0
     firebase_auth: ^4.0.0
     cloud_firestore: ^4.0.0
     firebase_remote_config: ^2.0.0
     provider: ^6.0.0
     http: ^0.13.3
     google_fonts: ^3.0.1
   ```

   Run `flutter pub get` again after making changes to the `pubspec.yaml`.

5. **Run the app**:

   Use the following command to run the app on an emulator or connected device:

   ```bash
   flutter run
   ```

6. **Access the app**:

   After running the app, you should be able to access the e-commerce application on your emulator or device.
```

### Summary of Installation Steps

1. Clone the repository.
2. Install Flutter dependencies.
3. Set up Firebase and configure it in your project.
4. Update the `pubspec.yaml` with required packages.
5. Run the app.

You can add any additional setup steps specific to your project as necessary!
