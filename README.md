# QuietBytes - Hobby Connection App

QuietBytes connects people with food recommendations using GPS location services. 
Explore new hobby experiences along with a new friend.

## Features
- 📍 **Location-based restaurant and event discovery** using GPS API
- 🍕 **Personalized food and event recommendations through notifications**
- 👥 **Social features** to connect with other hobby enthusiasts
- 🗺️ **Interactive map** view of nearby food and event spots

## Quick Start

### Prerequisites
- Flutter 3.38.9+
- iOS Simulator or physical device (for iOS testing)
- Chrome browser (for web testing)
- Firebase project with Auth and Firestore enabled
- `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) — not included in repo for security

### Installation
```bash
# Clone repository
git clone https://github.com/estherric/quietbytes.git
cd quietbytes

# Install dependencies
flutter pub get
```

## Running the App
### iOS Simulator (macOS only)
```
flutter run -d quietbytes
```

### Chrome Browser (macOS & Windows)
```
flutter run -d chrome
```
### macOS Desktop
```
flutter run -d macos
```

## Project Structure
```
lib/
├── app/
│   ├── auth_service.dart      # Firebase Auth & Firestore service methods
│   └── auth_layout.dart       # Auth state listener — routes to home or welcome
├── componets/
│   ├── custom_button.dart     # Reusable gold pill button
│   ├── custom_headers.dart    # Top pill header with back/settings icons
│   ├── custom_textfield.dart  # Reusable text input field
│   ├── mainshell.dart         # Bottom nav shell with page state management
│   ├── navigation_bar.dart    # Custom bottom navigation bar
│   ├── navigation_model.dart  # Navigation data model
│   ├── notification_tile.dart # Tappable notification list item
│   ├── settings_headers.dart  # Settings section header component
│   └── settings_tile.dart     # Tappable settings list item
├── features/
│   ├── blank.dart             # Discover page — faux map with event pins
│   ├── event_detail.dart      # Event detail page with RSVP functionality
│   ├── events.dart            # Events list page
│   ├── forgot_password.dart   # Forgot password page
│   ├── login.dart             # Login page
│   ├── notifications.dart     # Notifications page
│   ├── profile.dart           # Profile page with interests and RSVP'd events
│   ├── settings.dart          # Settings page
│   ├── settings_change_email.dart     # Change email page
│   ├── settings_change_password.dart  # Change password page
│   ├── settings_change_username.dart  # Change username page
│   ├── signup.dart            # Sign up page
│   ├── test.dart              # Dev navigation test page
│   ├── welcome.dart           # Welcome/landing page
│   └── chat.dart              # Chat page (placeholder)
├── theme/
│   ├── colors.dart            # App color palette
│   └── spacing.dart           # App spacing constants
├── firebase_options.dart      # Firebase configuration (auto-generated)
└── main.dart                  # App entry point and route definitions
```
