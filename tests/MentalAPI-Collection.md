Here’s how you can organize all your CRUD endpoints into a **Postman collection** so you can run them in sequence with one click:

---

## 🗂️ Step 1: Create a New Collection
1. Open **Postman**.
2. In the left sidebar, click **Collections → New Collection**.
3. Name it something like **Mental Health Quiz API**.
4. Add a short description (e.g., “CRUD operations for User management”).

---

## 📌 Step 2: Add Requests to the Collection
For each endpoint, create a request inside the collection:

- **Register User**  
  - Method: `POST`  
  - URL: `http://localhost/mental_health_quiz/api/auth/register.php`  
  - Body → raw → JSON:
    ```json
    {
      "username": "john_doe",
      "email": "john@example.com",
      "password": "secret123",
      "role": "user"
    }
    ```

- **Login User**  
  - Method: `POST`  
  - URL: `http://localhost/mental_health_quiz/api/auth/login.php`  
  - Body → raw → JSON:
    ```json
    {
      "email": "john@example.com",
      "password": "secret123"
    }
    ```

- **Get User by ID**  
  - Method: `GET`  
  - URL: `http://localhost/mental_health_quiz/api/users/get.php?id=1`

- **List All Users**  
  - Method: `GET`  
  - URL: `http://localhost/mental_health_quiz/api/users/list.php`

- **Update User**  
  - Method: `PUT` (or `POST`)  
  - URL: `http://localhost/mental_health_quiz/api/users/update.php`  
  - Body → raw → JSON:
    ```json
    {
      "id": 1,
      "username": "john_updated",
      "email": "john_updated@example.com"
    }
    ```

- **Delete User**  
  - Method: `DELETE` (or `POST`)  
  - URL: `http://localhost/mental_health_quiz/api/users/delete.php`  
  - Body → raw → JSON:
    ```json
    {
      "id": 1
    }
    ```

---

## ▶️ Step 3: Run Requests in Sequence
1. Open your collection.
2. Click the **Runner** button (top right).
3. Select all requests in order: Register → Login → Get → List → Update → Delete.
4. Hit **Run Collection**.
5. Postman will execute them one by one, showing results in sequence.

---

## ⚡ Extra Tip
You can add **environment variables** (like `{{base_url}}`) so you don’t have to repeat `http://localhost/mental_health_quiz` in every request.  
Example:  
- Set `base_url = http://localhost/mental_health_quiz` in your environment.  
- Use `{{base_url}}/api/auth/register.php` instead of hardcoding.

---

Would you like me to draft a **ready‑to‑import Postman JSON collection file** so you can just import it and have all these requests pre‑configured?