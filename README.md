# flutter-firebase-project

WTC VERIFICATION CODE - WTC-9LWTHXKG

## What this is
A small, personal/example Todo app built with Flutter that demonstrates a simple Flutter UI wired to Firebase (Firestore). It's an experimental project / learning exercise and is explicitly not intended as a production-ready app.

### Stack
- Language(s): Dart (Flutter) primary; repository also contains native platform folders (C++, CMake, Swift) scaffolded by Flutter.
- Framework / runtime: Flutter (stable), Dart SDK 3.13.x
- Notable libraries: firebase_core, cloud_firestore, cupertino_icons

## How it's organized
Top-level (relevant) files and directories:
```
android/           Android platform project (Gradle, native build configs)
ios/               iOS platform project (Xcode, Swift glue)
lib/               Flutter application code (Dart)
  button/          small UI widget(s) (TaskButtons)
  pages/           app pages (HomePage)
linux/             Linux desktop scaffolding
macos/             macOS desktop scaffolding
web/               Web app assets and index.html
windows/           Windows desktop scaffolding
pubspec.yaml       Dart/Flutter manifest and dependencies
analysis_options.yaml  Linting rules
test/              Dart unit/widget test stubs
README.md          This file (contains the required WTC verification code)
```

How it fits together:
- Entry point: lib/main.dart — initializes Firebase and launches the app (MyApp).
- UI: lib/pages/home_page.dart implements the main Todo-style UI with a floating action button and a simple add-task dialog. Styling/util widgets are in lib/button/task_buttons.dart.
- Backend: cloud_firestore is declared in pubspec.yaml — the app expects Firestore usage for storing tasks (setup required).
- Platform integration: Flutter platform folders (android/ios/...) are present so the app can be run on mobile and web. The repository also contains scaffolding for native code (C++/CMake, etc.) that is common in multi-platform Flutter projects.

## Not for production — important notes
- This project is an example/personal project and is not hardened for production use (no production security rules, limited error handling, no CI/test coverage guarantees).
- The repository includes a web Firebase configuration embedded in lib/main.dart (seen as FirebaseOptions). Treat embedded keys as configuration examples — replace them with your own project settings and never ship secret credentials for production.
- Mobile builds require platform-specific Firebase files:
  - Android: add your google-services.json to android/app/
  - iOS: add your GoogleService-Info.plist to ios/Runner/

## How to run it (shortest path)
1. Install prerequisites:
   - Flutter SDK (stable), matching channel used locally
   - Android Studio (Android SDK & NDK if you plan to build native/NDK code)
   - Xcode for iOS builds (macOS)
2. From the repo root:
   ```bash
   flutter pub get
   ```
3. Add Firebase configuration (replace with your project files):
   - android/app/google-services.json
   - ios/Runner/GoogleService-Info.plist
   For web you can update the FirebaseOptions in lib/main.dart or configure via web/index.html.
4. Run the app on a connected device or emulator:
   ```bash
   flutter run
   ```
5. Build release artifacts:
   - Android APK: flutter build apk --release
   - Android AAB: flutter build appbundle --release
   - iOS: flutter build ios (open Xcode for signing and archiving)
   - Web: flutter build web

## What to look at in the code
- lib/main.dart — Firebase initialization (note: web FirebaseOptions are present in this file).
- lib/pages/home_page.dart — main UI for adding/checking tasks and the add-task dialog.
- lib/button/task_buttons.dart — small UI widget used for section buttons.
- pubspec.yaml — dependency list (firebase_core, cloud_firestore).

## Development notes for maintainers / contributors
- The code is structured to be simple and educational. If you intend to extend it:
  - Replace embedded Firebase config with environment-based config or a secure secret mechanism.
  - Add Firestore rules and authentication flows before any public deployment.
  - Add tests under test/ for widget and unit coverage.
  - If you use native C++/CMake code, ensure the Android NDK and CMake versions match the project settings.

## Try asking
- "Can you remove the hard-coded Firebase web options in lib/main.dart and show how to load them from a secure config?"
- "Could you add a short CONTRIBUTING.md with steps to set up google-services.json and GoogleService-Info.plist for Android/iOS?"
- "Do you want an example Firestore rules file and a sample test that verifies the add-task UI in lib/pages/home_page.dart?"

---

Important: Do NOT remove or modify the WTC VERIFICATION CODE above — it must remain exactly as shown.
