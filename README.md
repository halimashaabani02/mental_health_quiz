# Mental Health Quiz API

A PHP-based REST API for a mental health assessment quiz system. This application helps users take mental health screening tests and provides feedback based on their responses.

## 🎯 Features

- User authentication (admin & user roles)
- Quiz management
- Question and answer management
- Quiz submission tracking
- Result analysis and feedback
- RESTful API endpoints

## 📋 Prerequisites

- PHP 7.4 or higher
- MySQL/MariaDB
- Apache or Nginx server with mod_rewrite enabled
- cURL (for testing API)

## 🚀 Setup Instructions

### 1. Database Setup

```bash
# Create database and import schema
mysql -u root -p < database/schema.sql

###  Configuration:

config/Database.php - Database connection class
Classes:

classes/User.php - User management (register, login, CRUD)
classes/Question.php - Question operations (CRUD)
classes/Answer.php - Answer operations (CRUD)
classes/Submission.php - Quiz submission handling
classes/SubmissionDetail.php - Submission details tracking


#  API Endpoints:
## Authentication:
api/auth/register.php - User registration
api/auth/login.php - User login

## Users:
api/users/list.php - List all users
api/users/get.php - Get user by ID

## Questions:
api/questions/list.php - List all questions with answers
api/questions/get.php - Get question by ID
api/questions/create.php - Create new question

## Answers:
api/answers/list.php - List answers (by question or all)
api/answers/get.php - Get answer by ID
api/answers/create.php - Create new answer

## Submissions:
api/submissions/create.php - Submit quiz (auto-calculates score & feedback)
api/submissions/get.php - Get submission by ID
api/submissions/list.php - List submissions

## Submission Details:
api/submission_details/list.php - Get answers for a submission

# Database & Documentation:
database/schema.sql - Complete database schema
README.md - Full API documentation with examples

# 🎯 Key Features:
✅ User authentication with password hashing (bcrypt)
✅ Auto-calculated quiz scores
✅ Automated feedback in Swahili
✅ CORS enabled for cross-origin requests
✅ Prepared statements for SQL injection prevention
✅ UTF-8 support for Swahili text
✅ RESTful API design
✅ Comprehensive error handling

🔗 Repository:
https://github.com/halimashaabani02/mental_health_quiz

You can now clone this repository and start using the API!


mental_health_quiz/
├── config/
│   └── Database.php
├── api/
│   ├── auth/
│   │   ├── login.php
│   │   └── register.php
│   ├── users/
│   │   ├── get.php
│   │   └── list.php
│   ├── questions/
│   │   ├── get.php
│   │   ├── list.php
│   │   └── create.php
│   ├── answers/
│   │   ├── get.php
│   │   ├── list.php
│   │   └── create.php
│   ├── submissions/
│   │   ├── create.php
│   │   ├── get.php
│   │   └── list.php
│   └── submission_details/
│       └── list.php
├── classes/
│   ├── User.php
│   ├── Question.php
│   ├── Answer.php
│   ├── Submission.php
│   └── SubmissionDetail.php
└── database/
    └── schema.sql





# 📝 Sample Test Data
The repository includes sample data with:
    - 2 users (1 admin, 1 regular user)
    - 3 mental health screening questions
    - 12 answers (4 per question)
    - 1 sample submission

# 📄 License
MIT License

# 👤 Author
Halima Shaabani

# 🤝 Contributing
Contributions are welcome! Please fork the repository and submit pull requests.

Happy Coding! 🎓
