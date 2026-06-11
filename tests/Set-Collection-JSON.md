Here’s a **ready‑to‑import Postman collection JSON** with all your CRUD requests pre‑configured. Save this as `mental_health_quiz_collection.json` and import it into Postman under **Collections**:

```json
{
  "info": {
    "name": "Mental Health Quiz API",
    "_postman_id": "mental-health-quiz-collection",
    "description": "CRUD operations for User management",
    "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json"
  },
  "item": [
    {
      "name": "Register User",
      "request": {
        "method": "POST",
        "header": [
          { "key": "Content-Type", "value": "application/json" }
        ],
        "body": {
          "mode": "raw",
          "raw": "{\n  \"username\": \"john_doe\",\n  \"email\": \"{{email}}\",\n  \"password\": \"{{password}}\",\n  \"role\": \"user\"\n}"
        },
        "url": {
          "raw": "{{base_url}}/api/auth/register.php",
          "host": ["{{base_url}}"],
          "path": ["api", "auth", "register.php"]
        }
      }
    },
    {
      "name": "Login User",
      "request": {
        "method": "POST",
        "header": [
          { "key": "Content-Type", "value": "application/json" }
        ],
        "body": {
          "mode": "raw",
          "raw": "{\n  \"email\": \"{{email}}\",\n  \"password\": \"{{password}}\"\n}"
        },
        "url": {
          "raw": "{{base_url}}/api/auth/login.php",
          "host": ["{{base_url}}"],
          "path": ["api", "auth", "login.php"]
        }
      }
    },
    {
      "name": "Get User by ID",
      "request": {
        "method": "GET",
        "url": {
          "raw": "{{base_url}}/api/users/get.php?id={{user_id}}",
          "host": ["{{base_url}}"],
          "path": ["api", "users", "get.php"],
          "query": [{ "key": "id", "value": "{{user_id}}" }]
        }
      }
    },
    {
      "name": "List All Users",
      "request": {
        "method": "GET",
        "url": {
          "raw": "{{base_url}}/api/users/list.php",
          "host": ["{{base_url}}"],
          "path": ["api", "users", "list.php"]
        }
      }
    },
    {
      "name": "Update User",
      "request": {
        "method": "PUT",
        "header": [
          { "key": "Content-Type", "value": "application/json" }
        ],
        "body": {
          "mode": "raw",
          "raw": "{\n  \"id\": {{user_id}},\n  \"username\": \"john_updated\",\n  \"email\": \"john_updated@example.com\"\n}"
        },
        "url": {
          "raw": "{{base_url}}/api/users/update.php",
          "host": ["{{base_url}}"],
          "path": ["api", "users", "update.php"]
        }
      }
    },
    {
      "name": "Delete User",
      "request": {
        "method": "DELETE",
        "header": [
          { "key": "Content-Type", "value": "application/json" }
        ],
        "body": {
          "mode": "raw",
          "raw": "{\n  \"id\": {{user_id}}\n}"
        },
        "url": {
          "raw": "{{base_url}}/api/users/delete.php",
          "host": ["{{base_url}}"],
          "path": ["api", "users", "delete.php"]
        }
      }
    }
  ]
}
```

---

## 🚀 How to Use
1. Save the JSON above as `mental_health_quiz_collection.json`.
2. In Postman, go to **Collections → Import → File** and select it.
3. Choose your **Mental Health Quiz Local** environment (with `base_url`, `email`, `password`, `user_id`).
4. Open the collection and run all requests in sequence using the **Collection Runner**.

---

This setup gives you a **full CRUD cycle** (Register → Login → Get → List → Update → Delete) ready to run with one click.  

Would you like me to also show you how to chain these requests in the runner (e.g., automatically use the `id` returned from Register in the later requests)?