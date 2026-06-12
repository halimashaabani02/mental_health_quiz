# MindCheck — Mental Health Quiz App

A Flutter mobile application that connects to the `mental_health_quiz` PHP REST API backend.

---

## Project Structure

```
lib/
├── constants/
│   ├── app_constants.dart   ← Base URL, endpoint paths, SharedPrefs keys
│   └── app_theme.dart       ← Material 3 theme, colors, typography
├── models/
│   ├── user_model.dart
│   ├── question_model.dart
│   ├── answer_model.dart
│   ├── submission_model.dart
│   └── submission_detail_model.dart
├── services/
│   ├── auth_service.dart
│   ├── question_service.dart
│   └── submission_service.dart
├── providers/
│   ├── auth_provider.dart
│   ├── quiz_provider.dart
│   └── history_provider.dart
├── screens/
│   ├── splash_screen.dart
│   ├── login_screen.dart
│   ├── register_screen.dart
│   ├── home_screen.dart
│   ├── quiz_screen.dart
│   ├── result_screen.dart
│   ├── history_screen.dart
│   └── submission_detail_screen.dart
├── widgets/
│   ├── custom_text_field.dart
│   ├── loading_widget.dart
│   └── error_widget.dart
└── utils/
    ├── session_manager.dart
    └── api_response.dart
```

---

## Setup Instructions

### 1. Prerequisites

- Flutter SDK ≥ 3.0.0 installed ([flutter.dev](https://flutter.dev))
- Android Studio or VS Code with Flutter plugin
- Your PHP backend running locally (XAMPP, WAMP, Laragon, etc.)
- MySQL database set up with the `mental_health_quiz` schema

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Configure the API base URL

Open `lib/constants/app_constants.dart` and set the correct IP:

| Scenario | Value |
|---|---|
| Android Emulator | `http://10.0.2.2/mental_health_quiz/api` |
| Physical Android device | `http://<YOUR_PC_LAN_IP>/mental_health_quiz/api` |
| iOS Simulator | `http://localhost/mental_health_quiz/api` |

To find your LAN IP (Windows): run `ipconfig` → look for IPv4 Address (e.g. `192.168.1.5`).

### 4. Allow cleartext HTTP (already set)

The `android/app/src/main/AndroidManifest.xml` already includes:
```xml
android:usesCleartextTraffic="true"
```
This is needed for `http://` (non-HTTPS) localhost connections during development.

### 5. Run the app

```bash
flutter run
```

---

## API Endpoints Used

| Feature | Method | Endpoint |
|---|---|---|
| Register | POST | `/auth/register.php` |
| Login | POST | `/auth/login.php` |
| Get questions | GET | `/questions/read.php` |
| Submit quiz | POST | `/submissions/create.php` |
| Get submissions | GET | `/submissions/read.php?user_id={id}` |
| Get submission detail | GET | `/submissions/read_one.php?id={id}` |

### Expected Request/Response Formats

**POST /auth/register.php**
```json
// Request
{ "username": "alice", "email": "alice@example.com", "password": "secret123" }
// Response
{ "success": true, "message": "Registration successful" }
```

**POST /auth/login.php**
```json
// Request
{ "email": "alice@example.com", "password": "secret123" }
// Response
{ "success": true, "user": { "id": 1, "username": "alice", "email": "...", "role": "user" } }
```

**GET /questions/read.php**
```json
// Response
{ "questions": [ { "id": 1, "question_text": "...", "answers": [ { "id": 1, "question_id": 1, "answer_text": "...", "score": 3 } ] } ] }
```

**POST /submissions/create.php**
```json
// Request
{ "user_id": 1, "answers": [ { "question_id": 1, "answer_id": 2 } ] }
// Response
{ "success": true, "score": 25, "feedback": "You're doing well!", "submission_id": 5 }
```

---

## State Management

Provider is used for all state management:

- **AuthProvider** — Login, register, logout, session persistence
- **QuizProvider** — Question loading, answer selection, quiz submission
- **HistoryProvider** — Past submissions list, submission detail view

---

## Notes for Production

1. Switch to HTTPS in production (`https://yourdomain.com/api`)
2. Add JWT token authentication (store token in SharedPreferences, send in headers)
3. Remove `android:usesCleartextTraffic="true"` in production builds
4. Add proper certificate pinning for security
