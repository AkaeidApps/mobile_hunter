# Mobile Hunter

Consent-based, real-time location sharing built with Flutter, Firebase
(Authentication + Cloud Firestore) and OpenStreetMap. No paid map API or credit
card is required.

## Feature overview

- Google (Gmail) sign-in and phone-number SMS OTP sign-in via Firebase Auth.
- Profile search by exact email/phone, pending requests, accept/reject consent.
- Live map with OpenStreetMap tiles, animated markers, reverse-geocoded address,
  speed (km/h), battery percentage and a recenter FAB.
- Foreground service that keeps streaming GPS + battery to Firestore every
  10 seconds / 10 metres while sharing is enabled.
- Material 3 UI using the royal blue (`#1E88E5`) palette.

## 1. Firebase setup

The app intentionally starts with a friendly configuration error when Firebase
is not set up, instead of crashing.

### Current status

Already wired up in this repository:

- Firebase project **`mobile-hunter-akaid`** (display name "Mobile Hunter") was
  created (`mobile-hunter` was already taken globally).
- Android app `com.example.mobile_hunter` and iOS app `com.example.mobileHunter`
  are registered. `lib/firebase_options.dart`,
  `android/app/google-services.json` and `ios/Runner/GoogleService-Info.plist`
  are generated, and `Firebase.initializeApp()` runs in `lib/main.dart`.
- The debug keystore SHA-1 and SHA-256 are registered for Google Sign-In. A web
  app (`Mobile Hunter (web)`) was created to supply the OAuth client.
- The Firestore `(default)` database was created and `firestore.rules` /
  `firestore.indexes.json` were deployed. `.firebaserc` pins the project, so
  `firebase deploy` works without `--project`.

Remaining one-time steps (Firebase creates the Auth config lazily in the
console; enabling it via the CLI requires Blaze billing):

1. Open <https://console.firebase.google.com/project/mobile-hunter-akaid/authentication/sign-in>
   and enable **Google** and **Phone**.
2. Re-download `android/app/google-services.json` after Google is enabled — it
   must contain a `client_type: 3` web OAuth client for Android Google Sign-In.
   Alternatively pass it at build time with
   `flutter run --dart-define=GOOGLE_SERVER_CLIENT_ID=<web-client-id>.apps.googleusercontent.com`.
3. Add the `REVERSED_CLIENT_ID` value from `ios/Runner/GoogleService-Info.plist`
   as a URL scheme in `ios/Runner/Info.plist` (it is not there yet because the
   iOS OAuth client is created when Google sign-in is enabled).
4. Register the SHA fingerprints of any other signing key you use (e.g. release)
   with `firebase apps:android:sha:create <appId> <shaHash>`.

The generic steps below are kept for reference when creating a fresh project.

1. Create a Firebase project at <https://console.firebase.google.com>.
2. Enable **Authentication -> Sign-in method -> Google** and **Phone**.
3. Add an **Android app** with package name `com.example.mobile_hunter`.
   Add the SHA-1 and SHA-256 fingerprints of every signing key you use:

   ```bash
   cd android && ./gradlew signingReport
   ```

4. Add an **iOS app** with bundle id `com.example.mobileHunter`.
5. Install the FlutterFire CLI and generate the native config files:

   ```bash
   dart pub global activate flutterfire_cli
   flutterfire configure --project <your-firebase-project-id>
   ```

   This writes `android/app/google-services.json` and
   `ios/Runner/GoogleService-Info.plist`, and registers the reversed client ID
   URL scheme for Google Sign-In on iOS.

6. Create a **Firestore database** (production mode) and deploy the security
   rules/indexes in this repository:

   ```bash
   firebase deploy --only firestore:rules,firestore:indexes
   ```

7. Google Sign-In on Android uses the web OAuth client from
   `google-services.json`. If that file has no `client_type: 3` entry, add a Web
   app in Firebase and re-download it, or pass your Web client ID at build time:

   ```bash
   flutter run --dart-define=GOOGLE_SERVER_CLIENT_ID=<web-client-id>.apps.googleusercontent.com
   ```

## 2. Platform notes

- **Android**: `minSdk` is 23, and the manifest declares foreground-service
  location, background location, notifications and boot permissions. The app
  asks for "while in use" first and then routes the user to settings for
  "Allow all the time". On Android 12+ the user must also disable battery
  optimisation for reliable background tracking.
- **iOS**: `Info.plist` contains the location usage descriptions, background
  modes (`location`, `fetch`, `remote-notification`) and the background task
  identifier used by `flutter_background_service`. iOS periodically suspends
  background apps; the plugin uses Background Fetch, so updates may be batched
  by the OS when the app is not in use.
- The OpenStreetMap tile server requires a valid user agent (configured in
  `lib/features/tracking/presentation/screens/live_map_screen.dart`) and
  attribution is displayed on the map.

## 3. Run

```bash
flutter pub get
flutter run
```

## 4. Firestore schema

`users/{uid}`

```json
{
  "uid": "string",
  "name": "string",
  "email": "string",
  "phone": "string",
  "photoUrl": "string",
  "isSharing": true,
  "latitude": 23.8103,
  "longitude": 90.4125,
  "speed": 1.42,
  "batteryLevel": 86,
  "lastUpdated": "<timestamp>"
}
```

`connections/{autoId}`

```json
{
  "id": "autoId",
  "senderId": "uid",
  "senderName": "string",
  "senderContact": "email-or-phone",
  "receiverId": "uid",
  "receiverName": "string",
  "receiverContact": "email-or-phone",
  "status": "pending | accepted",
  "createdAt": "<timestamp>"
}
```

Rejecting a request deletes the pending document; removing a connection deletes
the accepted document. Only `accepted` connections are listed on the dashboard
and can be opened on the live map.
