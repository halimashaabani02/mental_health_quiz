Here’s a **ready‑to‑import Postman environment JSON** you can use. Save this as a `.json` file (e.g., `mental_health_quiz_env.json`) and import it into Postman under **Environments**:

```json
{
  "id": "mental-health-quiz-env",
  "name": "Mental Health Quiz Local",
  "values": [
    {
      "key": "base_url",
      "value": "http://localhost/mental_health_quiz",
      "enabled": true
    },
    {
      "key": "user_id",
      "value": "1",
      "enabled": true
    },
    {
      "key": "email",
      "value": "john@example.com",
      "enabled": true
    },
    {
      "key": "password",
      "value": "secret123",
      "enabled": true
    }
  ],
  "_postman_variable_scope": "environment",
  "_postman_exported_at": "2026-06-11T03:24:00.000Z",
  "_postman_exported_using": "Postman/10.0.0"
}
```

---

## 🚀 How to Import
1. Open **Postman**.
2. Click the gear icon (⚙️) in the top right → **Manage Environments**.
3. Click **Import** and select the JSON file you saved.
4. Select this environment in the top‑right dropdown when running requests.

---

## 🧩 How to Use Variables
- Replace hardcoded URLs with `{{base_url}}`:
  - `{{base_url}}/api/auth/register.php`
- Replace IDs with `{{user_id}}`:
  - `{{base_url}}/api/users/get.php?id={{user_id}}`
- Replace credentials with `{{email}}` and `{{password}}` in request bodies.

This way, if you move your API from `localhost` to a server, you only need to update `base_url` in one place.

Would you like me to also draft a **Postman collection JSON** with all CRUD requests pre‑configured, so you can import both the environment and collection and run everything instantly?