Got it — if you don’t want to use **environment variables** in Postman, you can hardcode all values directly in each request. Here’s a full set of CRUD endpoints you can paste into Postman with fixed values:

---

## 🛠️ CRUD Requests Without Environment Variables

### **Register User**
- **Method:** POST  
- **URL:** `http://localhost/mental_health_quiz/api/auth/register.php`  
- **Body (raw JSON):**
```json
{
  "username": "halima",
  "email": "halima@example.com",
  "password": "secret123",
  "role": "user"
}
```

---

### **Login User**
- **Method:** POST  
- **URL:** `http://localhost/mental_health_quiz/api/auth/login.php`  
- **Body (raw JSON):**
```json
{
  "email": "halima@example.com",
  "password": "secret123"
}
```

---

### **Get User by ID**
- **Method:** GET  
- **URL:**  
  ```
  http://localhost/mental_health_quiz/api/users/get.php?id=1
  ```
*(Replace `1` with the actual user ID you want to fetch.)*

---

### **List All Users**
- **Method:** GET  
- **URL:**  
  ```
  http://localhost/mental_health_quiz/api/users/list.php
  ```

---

### **Update User**
- **Method:** PUT (or POST depending on your PHP setup)  
- **URL:** `http://localhost/mental_health_quiz/api/users/update.php`  
- **Body (raw JSON):**
```json
{
  "id": 1,
  "username": "halima_updated",
  "email": "halima_updated@example.com"
}
```

---

### **Delete User**
- **Method:** DELETE (or POST depending on your PHP setup)  
- **URL:** `http://localhost/mental_health_quiz/api/users/delete.php`  
- **Body (raw JSON):**
```json
{
  "id": 1
}
```

---

## 📌 Key Notes
- Replace `id=1` or `"id": 1` with the actual user ID you want to test.  
- Since you’re not using environment variables, every request must be updated manually if the ID, email, or password changes.  
- This setup is simpler for testing, but less flexible than using `{{variables}}`.

---

Would you like me to also prepare a **ready‑to‑import Postman collection JSON** with these hardcoded values, so you can import it directly instead of creating each request manually?