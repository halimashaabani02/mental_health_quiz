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