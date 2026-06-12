# Mental Health Quiz Game Flutter App Development Prompt

I want you to act as a Senior Flutter Developer and Software Architect.

Build a complete Flutter mobile application called **Mental Health Quiz Game** that consumes an existing PHP REST API backend.

## Project Overview

The application is a Mental Health Quiz Game where users answer mental-health-related questions and receive feedback based on their submissions.

There are two types of users:

1. Admin
2. Normal User

The Flutter application should primarily focus on the Normal User experience, but the architecture should be scalable enough to support admin features later.

The backend API is already developed in PHP and MySQL. It is available locally through base url http://localhost/mental_health_quiz/api 

All API endpoints and backend structure can be found in this GitHub repository:

https://github.com/halimashaabani02/mental_health_quiz/tree/main/api

Please inspect the repository structure and use the existing endpoints exactly as implemented.

Do not create fake endpoints.

Use the actual endpoint structure from the repository.

---

## Technical Requirements

### Frontend Framework

* Flutter (latest stable version)
* Dart

### State Management

Choose one of the following:

* Provider (preferred)
* Riverpod

### Networking

Use:

* http package

or

* dio package

### Local Storage

Use:

* SharedPreferences

Store:

* User login information
* User session
* User role

### Architecture

Use a clean folder structure:

lib/
├── models/
├── services/
├── providers/
├── screens/
├── widgets/
├── utils/
├── constants/
└── main.dart

Follow separation of concerns and clean code principles.

---

## Authentication Module

### Registration Screen

Create a registration page with:

* Username
* Email
* Password
* Confirm Password
* Register Button

Validation:

* Empty fields
* Invalid email
* Password mismatch

After successful registration:

* Show success message
* Navigate to Login Screen

---

### Login Screen

Create a login page with:

* Email
* Password
* Login Button

Upon successful login:

* Save session locally
* Save user role
* Redirect user to Home Screen

Handle:

* Invalid credentials
* Server errors
* Network errors

---

## Splash Screen

Create a professional splash screen.

Behavior:

* Check if user session exists
* If logged in → Home Screen
* Otherwise → Login Screen

---

## Home Screen

Display:

* Welcome message
* Username
* Quiz button
* Quiz history button
* Logout button

Design should be modern and responsive.

---

## Quiz Module

### Fetch Questions

Load questions dynamically from the API.

Each question should display:

* Question text
* Multiple answer options

Use:

* Radio buttons
* Cards
* Clean UI

The number of questions should come from the API.

No hardcoded questions.

---

### Quiz Screen Features

Show:

* Question number
* Progress indicator
* Selected answer

Navigation:

* Next Question
* Previous Question

After the final question:

* Submit Quiz button

---

## Quiz Submission

When the user submits:

Send all selected answers to the backend API.

The request should match the existing backend implementation.

After submission:

Receive:

* Score
* Feedback
* Submission ID (if provided)

Display the results immediately.

---

## Result Screen

Show:

* User Score
* Feedback Message
* Date Submitted
* Retry Quiz Button
* Return Home Button

Design should be visually appealing.

---

## Quiz History Module

Create a page that retrieves all previous submissions from the API.

Display:

* Submission ID
* Score
* Feedback
* Submission Date

Allow user to tap a record and view details.

---

## Submission Details Screen

Display:

* Questions
* Selected Answers
* Submission Information

Retrieve data using the existing submission details API endpoint.

---

## Logout Functionality

When logout is pressed:

* Clear SharedPreferences
* Return to Login Screen

---

## UI Requirements

Create a modern mobile UI.

Use:

* Material Design 3
* Cards
* Icons
* Loading indicators
* Empty states
* Error states

Ensure responsive layouts for:

* Android phones
* Android tablets

---

## Error Handling

Handle:

* API failures
* Timeout errors
* No internet connection
* Invalid JSON responses

Show user-friendly messages.

---

## Models

Generate strongly typed Dart models for:

* User
* Question
* Answer
* Submission
* SubmissionDetail

Include:

* fromJson()
* toJson()

methods.

---

## Services

Create dedicated API service classes:

* AuthService
* UserService
* QuestionService
* AnswerService
* SubmissionService

Do not place networking code directly inside screens.

---

## Deliverables

Generate:

1. Complete Flutter source code.
2. Folder structure.
3. Dart models.
4. API services.
5. Screens.
6. Reusable widgets.
7. Navigation flow.
8. State management implementation.
9. SharedPreferences integration.
10. Full setup instructions.

Ensure the project is production-ready, clean, scalable, and compatible with the existing PHP API backend from the GitHub repository.
