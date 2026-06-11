Sawa 👍 nitakupa **Postman collection ya Questions API** kwa format nzuri unaweza copy moja kwa moja au import kwenye Postman.

Nimeifuata structure yako (`questions/list.php`, `get.php`, `create.php`).

---

# 🟢 📦 POSTMAN COLLECTION — QUESTIONS API

## 👉 Option 1: Manual Requests (copy & use directly)

---

# 📥 1. GET ALL QUESTIONS (LIST)

### 🔹 Method:

```text
GET
```

### 🔹 URL:

```text
http://localhost/mental_health_quiz/api/questions/list.php
```

### 🔹 Expected Response:

```json
[
  {
    "id": 1,
    "question_text": "Je, unapata shida ya usingizi?",
    "answers": [
      {
        "id": 1,
        "answer_text": "Kabisa",
        "is_correct": 1
      },
      {
        "id": 2,
        "answer_text": "Mara chache",
        "is_correct": 0
      }
    ]
  }
]
```

---

# 📥 2. GET SINGLE QUESTION

### 🔹 Method:

```text
GET
```

### 🔹 URL:

```text
http://localhost/mental_health_quiz/api/questions/get.php?id=1
```

---

### 🔹 Expected Response:

```json
{
  "id": 1,
  "question_text": "Je, unapata shida ya usingizi?",
  "answers": [
    {
      "id": 1,
      "answer_text": "Kabisa"
    },
    {
      "id": 2,
      "answer_text": "Mara chache"
    }
  ]
}
```

---

# ➕ 3. CREATE QUESTION (ADMIN ONLY)

### 🔹 Method:

```text
POST
```

### 🔹 URL:

```text
http://localhost/mental_health_quiz/api/questions/create.php
```

---

### 🔹 Body (JSON):

```json
{
  "question_text": "Je, unajisikia mwenye wasiwasi mara kwa mara?"
}
```

---

### 🔹 Expected Response:

```json
{
  "status": true,
  "message": "Question created successfully"
}
```

---

# ✏️ 4. UPDATE QUESTION (optional but muhimu)

### 🔹 Method:

```text
POST
```

### 🔹 URL:

```text
http://localhost/mental_health_quiz/api/questions/update.php
```

---

### 🔹 Body:

```json
{
  "id": 1,
  "question_text": "Updated question text"
}
```

---

# ❌ 5. DELETE QUESTION

### 🔹 Method:

```text
POST
```

### 🔹 URL:

```text
http://localhost/mental_health_quiz/api/questions/delete.php
```

---

### 🔹 Body:

```json
{
  "id": 1
}
```

---

# 🟢 BONUS — RECOMMENDED POSTMAN SETTINGS

Kila request ongeza headers hizi:

```json
Content-Type: application/json
```

---

# 🔥 BONUS 2 — BEST PRACTICE RESPONSE FORMAT

Ili project yako ionekane PROFESSIONAL, badilisha API zote zitoe response kama hii:

```json
{
  "status": true,
  "message": "Success",
  "data": []
}
```

---

# 📦 BONUS 3 — POSTMAN COLLECTION FILE (OPTIONAL)

Kama unataka, naweza kukutengenezea:

👉 `.json file` ya Postman import moja kwa moja (collection tayari imeorganize folders)

---

# 🚀 NEXT STEP (IMPORTANT)

Sasa baada ya questions API:

👉 hatua inayofuata ni **SUBMIT QUIZ API (core ya project)**

Hapo ndipo:

* score inahesabiwa
* feedback inatolewa
* results zinahifadhiwa

---

# NIAMBIE:

Unataka nikufanyie ipi next?

1. 🔥 Submit Quiz API (core logic ya system)
2. 📱 Flutter integration ya questions API
3. 📦 Postman collection file (ready import)
4. 📊 Results API (history ya user)

Chagua moja tuendelee kujenga project yako haraka 🚀
