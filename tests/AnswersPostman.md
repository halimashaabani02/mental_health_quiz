Sawa 👍 hapa chini nimekutengenezea **Postman Collection ya Answers API** kwa format ile ile unayotumia. Unaweza copy moja kwa moja kwenye Postman au kuitumia kama reference ya ku-test endpoints zako.

---

# 🟢 📦 POSTMAN COLLECTION — ANSWERS API

## 👉 Base URL:

```text
http://localhost/mental_health_quiz/api/answers/
```

---

# 📥 1. GET ALL ANSWERS (LIST)

### 🔹 Method:

```text id="a1k9q2"
GET
```

### 🔹 URL:

```text id="b7m3x1"
http://localhost/mental_health_quiz/api/answers/list.php
```

---

### 🔹 Expected Response:

```json id="c9p2z8"
[
  {
    "id": 1,
    "question_id": 1,
    "answer_text": "Kabisa (Sipati shida)",
    "is_correct": 1
  },
  {
    "id": 2,
    "question_id": 1,
    "answer_text": "Siku chache",
    "is_correct": 0
  }
]
```

---

# 📥 2. GET SINGLE ANSWER

### 🔹 Method:

```text id="d3x8k5"
GET
```

### 🔹 URL:

```text id="e4n7q1"
http://localhost/mental_health_quiz/api/answers/get.php?id=1
```

---

### 🔹 Expected Response:

```json id="f2m9w6"
{
  "id": 1,
  "question_id": 1,
  "answer_text": "Kabisa (Sipati shida)",
  "is_correct": 1
}
```

---

# ➕ 3. CREATE ANSWER (ADMIN)

### 🔹 Method:

```text id="g5q2n8"
POST
```

### 🔹 URL:

```text id="h8w1t3"
http://localhost/mental_health_quiz/api/answers/create.php
```

---

### 🔹 Body (JSON):

```json id="i6k3p9"
{
  "question_id": 1,
  "answer_text": "Mara chache",
  "is_correct": 0
}
```

---

### 🔹 Expected Response:

```json id="j9m4x2"
{
  "status": true,
  "message": "Answer created successfully"
}
```

---

# ✏️ 4. UPDATE ANSWER

### 🔹 Method:

```text id="k2p8w7"
POST
```

### 🔹 URL:

```text id="l5x1q9"
http://localhost/mental_health_quiz/api/answers/update.php
```

---

### 🔹 Body:

```json id="m3n6t4"
{
  "id": 1,
  "question_id": 1,
  "answer_text": "Updated answer text",
  "is_correct": 1
}
```

---

### 🔹 Expected Response:

```json id="n8q2w5"
{
  "status": true,
  "message": "Answer updated successfully"
}
```

---

# ❌ 5. DELETE ANSWER

### 🔹 Method:

```text id="o1x7k9"
POST
```

### 🔹 URL:

```text id="p4m2q8"
http://localhost/mental_health_quiz/api/answers/delete.php
```

---

### 🔹 Body:

```json id="q7w3n1"
{
  "id": 1
}
```

---

### 🔹 Expected Response:

```json id="r9k5x2"
{
  "status": true,
  "message": "Answer deleted successfully"
}
```

---

# 🟡 6. IMPORTANT NOTES (MUHIMU KWA PROJECT YAKO)

## ✔ 1. Headers (ongeza kila request)

```json id="s2m8q1"
Content-Type: application/json
```

---

## ✔ 2. Relationship check

Kumbuka:

* `answers.question_id` → inatoka `questions.id`

👉 Usijaribu ku-create answer bila question kuwepo

---

## ✔ 3. Recommended API response format

Ili project yako iwe professional:

```json id="t6x1p9"
{
  "status": true,
  "message": "Success",
  "data": []
}
```

---

# 🔥 BONUS (VERY IMPORTANT FOR YOUR PROJECT)

Kwa Mental Health Quiz, answers zako ni vizuri ziwe na:

| answer_text   | score |
| ------------- | ----- |
| Kabisa        | 0     |
| Siku chache   | 1     |
| Mara kwa mara | 2     |
| Kila siku     | 3     |

👉 Hii ni better kuliko `is_correct`

---

# 🚀 NEXT STEP (NINAPENDEKEZA)

Sasa umecomplete:

✔ Users API
✔ Questions API
✔ Answers API

👉 Next BIG STEP:

## 🔥 SUBMISSIONS API (CORE LOGIC)

Hapo ndipo:

* score inahesabiwa
* feedback inatolewa
* results zinahifadhiwa

---

# NIAMBIE:

Unataka nikuandae nini next?

1. 🔥 Submit Quiz API (heart ya project)
2. 📊 Submissions GET + history API
3. 📱 Flutter integration ya quiz flow
4. 📦 Postman collection full (users + questions + answers + submissions)

Chagua moja tuanze next level 🚀
