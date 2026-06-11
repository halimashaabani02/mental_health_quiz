Sawa 👍 hapa chini nimekukusanyia **Postman Collection ya Submission Details API** kwa format ile ile unayotumia kwenye project yako.

Hii sehemu ni muhimu kwa:

* kuonyesha answers alizochagua user
* tracking ya quiz history
* debugging ya score logic

---

# 🟢 📦 POSTMAN COLLECTION — SUBMISSION DETAILS API

## 👉 Base URL:

```text id="sd_base"
http://localhost/mental_health_quiz/api/submission_details/
```

---

# 📥 1. GET ALL SUBMISSION DETAILS (LIST)

## 🔹 Method:

```text id="sd1"
GET
```

## 🔹 URL:

```text id="sd2"
http://localhost/mental_health_quiz/api/submission_details/list.php
```

---

## 🔹 Expected Response:

```json id="sd3"
[
  {
    "id": 1,
    "submission_id": 1,
    "question_id": 1,
    "selected_answer_id": 1
  },
  {
    "id": 2,
    "submission_id": 1,
    "question_id": 2,
    "selected_answer_id": 5
  }
]
```

---

# 📥 2. GET DETAILS BY SUBMISSION ID (MUHIMU 🔥)

## 🔹 Method:

```text id="sd4"
GET
```

## 🔹 URL:

```text id="sd5"
http://localhost/mental_health_quiz/api/submission_details/list.php?submission_id=1
```

---

## 🔹 Expected Response:

```json id="sd6"
{
  "submission_id": 1,
  "details": [
    {
      "question_id": 1,
      "question_text": "Je, unapata shida ya usingizi?",
      "selected_answer": "Kabisa (Sipati shida)",
      "is_correct": 1
    },
    {
      "question_id": 2,
      "question_text": "Je, unajisikia wasiwasi?",
      "selected_answer": "Mara chache",
      "is_correct": 0
    }
  ]
}
```

---

# 📥 3. GET DETAILS BY USER (OPTIONAL BUT VERY USEFUL)

## 🔹 Method:

```text id="sd7"
GET
```

## 🔹 URL:

```text id="sd8"
http://localhost/mental_health_quiz/api/submission_details/list.php?user_id=2
```

---

## 🔹 Expected Response:

```json id="sd9"
[
  {
    "submission_id": 1,
    "question_id": 1,
    "selected_answer_id": 1
  },
  {
    "submission_id": 1,
    "question_id": 2,
    "selected_answer_id": 5
  }
]
```

---

# 🟡 4. GET SINGLE DETAIL (OPTIONAL)

## 🔹 Method:

```text id="sd10"
GET
```

## 🔹 URL:

```text id="sd11"
http://localhost/mental_health_quiz/api/submission_details/get.php?id=1
```

---

## 🔹 Expected Response:

```json id="sd12"
{
  "id": 1,
  "submission_id": 1,
  "question_id": 1,
  "selected_answer_id": 1
}
```

---

# 🟢 5. CREATE DETAIL (RARELY USED MANUALLY)

👉 Hii normally huwezi ku-test sana manually (inasimamiwa na `submissions/create.php`)

## 🔹 Method:

```text id="sd13"
POST
```

## 🔹 URL:

```text id="sd14"
http://localhost/mental_health_quiz/api/submission_details/create.php
```

---

## 🔹 Body:

```json id="sd15"
{
  "submission_id": 1,
  "question_id": 1,
  "selected_answer_id": 1
}
```

---

## 🔹 Response:

```json id="sd16"
{
  "status": true,
  "message": "Submission detail saved"
}
```

---

# 🟡 6. DELETE DETAIL (ADMIN ONLY)

## 🔹 Method:

```text id="sd17"
POST
```

## 🔹 URL:

```text id="sd18"
http://localhost/mental_health_quiz/api/submission_details/delete.php
```

---

## 🔹 Body:

```json id="sd19"
{
  "id": 1
}
```

---

## 🔹 Response:

```json id="sd20"
{
  "status": true,
  "message": "Deleted successfully"
}
```

---

# 🔥 7. MUHIMU KWA PROJECT YAKO (LOGIC)

Submission details zinatakiwa:

✔ Kuhifadhi kila jibu la user
✔ Ku-link:

* submission_id
* question_id
* selected_answer_id

✔ Kutumika ku-display result breakdown

---

# 🟢 8. BEST PRACTICE RESPONSE (PRO LEVEL)

Badala ya simple response, tumia:

```json id="sd21"
{
  "status": true,
  "message": "success",
  "data": []
}
```

---

# 🚀 9. SYSTEM FLOW (HII NI CORE YA PROJECT)

1. User answers quiz
2. `submissions/create.php` inaitwa
3. In-save:

   * submissions table
   * submission_details table
4. Results zinareturn
5. Flutter ina-display breakdown

---

# 🔥 FINAL NOTE

Sasa umecomplete Postman collections za:

✔ Users API
✔ Auth API
✔ Questions API
✔ Answers API
✔ Submissions API
✔ Submission Details API

👉 Backend yako sasa iko **80–90% ready kwa Flutter integration**

---

# NIAMBIE NEXT STEP:

Unataka nikuandalie nini sasa?

1. 🔥 FULL PHP code ya `submit quiz (create.php)` — CORE LOGIC
2. 📱 Flutter quiz screen + API integration
3. 📊 Results/Analytics dashboard API
4. 📦 COMPLETE Postman collection (1 file import)

Chagua tuanze next level 🚀
