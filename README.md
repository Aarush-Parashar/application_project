# Flutter Auth & Profile Manager

A comprehensive Flutter application with Firebase authentication, user profile management, and customizable settings.


## Features

- **Firebase Authentication**
  - Email/Password Login & Registration
  - Google Sign-In Integration
  - Persistent Authentication State
  
- **User Profile Management**
  - Edit Personal Information
  - Profile Picture Management
  - Bio and Contact Information

- **Comprehensive Settings**
  - Appearance Options (Dark Mode, Text Size)
  - Notification Preferences
  - Privacy & Security Settings
  - Language & Region Selection
  - Account Management

- **Clean & Modern UI**
  - Material Design Implementation
  - Responsive Layouts
  - Platform-Specific UI Components (iOS/Android)


## Getting Started

### Prerequisites

- Flutter SDK (2.0.0 or higher)
- Dart SDK (2.12.0 or higher)
- Firebase Project

### Firebase Setup

1. Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Enable Authentication services (Email/Password and Google)
3. Download and add the `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) to the respective folders
4. Update the Firebase configuration in `lib/firebase_options.dart`

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/Aarush-Parashar/application_project.git
   cd application_project
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the application:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── main.dart                  # Application entry point
├── firebase_options.dart      # Firebase configuration
├── screens/
│   ├── home_screen.dart       # Main dashboard screen
│   ├── login_screen.dart      # Authentication screen
│   └── settings.dart          # User settings screen
├── services/
│   └── auth_services.dart     # Authentication services
└── widgets/
    ├── login_button.dart      # Social login button
    └── logout_button.dart     # Logout functionality
```

## Dependencies

- **firebase_core**: ^2.7.0
- **firebase_auth**: ^4.2.2
- **google_sign_in**: ^6.0.2
- **shared_preferences**: ^2.0.18
- **flutter**: sdk: flutter

## State Management

The application uses Flutter's built-in `StatefulWidget` and `setState` for state management, making it easy to understand and maintain.

## Authentication Flow

1. User lands on the `LoginScreen`
2. Authentication state is monitored via `FirebaseAuth.instance.authStateChanges()`
3. Upon successful login/registration, user is redirected to `HomeScreen`
4. Logout returns user to `LoginScreen`

## Customization

### Theme

You can customize the application theme by modifying the `ThemeData` in `main.dart`:

```dart
theme: ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  // Add your custom theme properties here
),
```

### Firebase Configuration

Update the Firebase configuration in `firebase_options.dart` with your project-specific settings.

## Contribution

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- [Flutter](https://flutter.dev/)
- [Firebase](https://firebase.google.com/)
- [Material Design](https://material.io/design)

