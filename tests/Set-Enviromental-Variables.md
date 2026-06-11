Here’s how you can add **environment variables** in Postman so your requests are cleaner and reusable:

---

## 🌍 Step 1: Create an Environment
1. In Postman, click the **Environments** tab (gear icon in the top right).
2. Click **Add Environment**.
3. Name it something like **Mental Health Quiz Local**.
4. Add variables such as:
   - `base_url` → `http://localhost/mental_health_quiz`
   - `user_id` → `1`
   - `email` → `john@example.com`
   - `password` → `secret123`

---

## 📝 Step 2: Use Variables in Requests
Instead of hardcoding values, replace them with double curly braces:

- **Register User**
  ```
  {{base_url}}/api/auth/register.php
  ```
  Body:
  ```json
  {
    "username": "john_doe",
    "email": "{{email}}",
    "password": "{{password}}",
    "role": "user"
  }
  ```

- **Login User**
  ```
  {{base_url}}/api/auth/login.php
  ```
  Body:
  ```json
  {
    "email": "{{email}}",
    "password": "{{password}}"
  }
  ```

- **Get User by ID**
  ```
  {{base_url}}/api/users/get.php?id={{user_id}}
  ```

- **List All Users**
  ```
  {{base_url}}/api/users/list.php
  ```

- **Update User**
  ```
  {{base_url}}/api/users/update.php
  ```
  Body:
  ```json
  {
    "id": {{user_id}},
    "username": "john_updated",
    "email": "john_updated@example.com"
  }
  ```

- **Delete User**
  ```
  {{base_url}}/api/users/delete.php
  ```
  Body:
  ```json
  {
    "id": {{user_id}}
  }
  ```

---

## ▶️ Step 3: Run with Collection Runner
1. Select your **Mental Health Quiz API** collection.
2. Choose the **Mental Health Quiz Local** environment.
3. Run the collection — Postman will substitute all variables automatically.

---

This way, if you move your API from `localhost` to a server (e.g., `https://myapi.com`), you only update `base_url` once in the environment instead of editing every request.

Would you like me to draft a **ready‑to‑import Postman environment JSON file** with these variables pre‑configured so you can just import it and start testing?