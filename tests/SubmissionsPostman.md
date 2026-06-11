Sawa 👍 hapa chini nimekutengenezea **Postman Collection ya Submissions API** kwa format ile ile unayotumia (ready kabisa ku-test kwenye Postman).

Hii ndiyo **core ya project yako** kwa sababu hapa ndipo quiz inasubmitiwa, score inahesabiwa, na feedback inatolewa.

---

# 🟢 📦 POSTMAN COLLECTION — SUBMISSIONS API

## 👉 Base URL:

```text id="sub_base"
http://localhost/mental_health_quiz/api/submissions/
```

---

# 📥 1. SUBMIT QUIZ (CORE ENDPOINT 🔥)

## 🔹 Method:

```text id="sub1"
POST
```

## 🔹 URL:

```text id="sub2"
http://localhost/mental_health_quiz/api/submissions/create.php
```

---

## 🔹 Body (JSON):

```json id="sub3"
{
  "user_id": 2,
  "answers": [
    {
      "question_id": 1,
      "selected_answer_id": 1
    },
    {
      "question_id": 2,
      "selected_answer_id": 5
    },
    {
      "question_id": 3,
      "selected_answer_id": 9
    }
  ]
}
```

---

## 🔹 Expected Response:

```json id="sub4"
{
  "status": true,
  "score": 80,
  "feedback": "Hongera! Una afya nzuri ya akili.",
  "submission_id": 1
}
```

---

# 📥 2. GET ALL SUBMISSIONS (LIST)

## 🔹 Method:

```text id="sub5"
GET
```

## 🔹 URL:

```text id="sub6"
http://localhost/mental_health_quiz/api/submissions/list.php
```

---

## 🔹 Expected Response:

```json id="sub7"
[
  {
    "id": 1,
    "user_id": 2,
    "score": 80,
    "feedback": "Hongera! Una afya nzuri ya akili.",
    "submitted_at": "2026-06-11 10:20:00"
  }
]
```

---

# 📥 3. GET SINGLE SUBMISSION

## 🔹 Method:

```text id="sub8"
GET
```

## 🔹 URL:

```text id="sub9"
http://localhost/mental_health_quiz/api/submissions/get.php?id=1
```

---

## 🔹 Expected Response:

```json id="sub10"
{
  "id": 1,
  "user_id": 2,
  "score": 80,
  "feedback": "Hongera! Una afya nzuri ya akili.",
  "answers": [
    {
      "question_id": 1,
      "selected_answer_id": 1
    },
    {
      "question_id": 2,
      "selected_answer_id": 5
    }
  ]
}
```

---

# 🟡 4. SUBMISSIONS BY USER (OPTIONAL BUT VERY USEFUL)

## 🔹 Method:

```text id="sub11"
GET
```

## 🔹 URL:

```text id="sub12"
http://localhost/mental_health_quiz/api/submissions/list.php?user_id=2
```

---

## 🔹 Expected Response:

```json id="sub13"
[
  {
    "id": 1,
    "score": 80,
    "feedback": "Hongera!",
    "submitted_at": "2026-06-11"
  }
]
```

---

# 🟡 5. DELETE SUBMISSION (ADMIN ONLY)

## 🔹 Method:

```text id="sub14"
POST
```

## 🔹 URL:

```text id="sub15"
http://localhost/mental_health_quiz/api/submissions/delete.php
```

---

## 🔹 Body:

```json id="sub16"
{
  "id": 1
}
```

---

## 🔹 Response:

```json id="sub17"
{
  "status": true,
  "message": "Submission deleted successfully"
}
```

---

# 🟢 6. IMPORTANT LOGIC (HII NI CORE YA PROJECT 🔥)

Katika `create.php` backend yako inapaswa kufanya:

### Step 1: Pokea answers

### Step 2: Loop kila answer

### Step 3: Check score kutoka answers table

### Step 4: Jumlisha score

### Step 5: Generate feedback

Example logic:

```php id="logic1"
if($score <= 3){
   $feedback = "Low stress level 👍";
} elseif($score <= 6){
   $feedback = "Moderate stress ⚠️";
} else {
   $feedback = "High stress 🚨 Please seek support";
}
```

### Step 6: Save submissions table

### Step 7: Save submission_details table

### Step 8: Return response

---

# 🟡 7. HEADERS (MUHIMU KWA POSTMAN)

Ongeza kwenye kila request:

```json id="hdr1"
Content-Type: application/json
```

---

# 🔥 8. SYSTEM FLOW (UKIWA NA FLUTTER)

1. User login ✔
2. Get questions ✔
3. User selects answers ✔
4. Submit quiz → `/submissions/create.php` ✔
5. Get result ✔
6. Show feedback ✔

---

# 🚀 FINAL NOTE

Sasa umecomplete:

✔ Users API
✔ Questions API
✔ Answers API
✔ Submissions API (core)

👉 Hii backend yako iko **80–85% ready kwa Flutter integration**

---

# NIAMBIE NEXT STEP:

Unataka nikuandalie nini sasa?

1. 🔥 FULL PHP code ya `create.php` (submit quiz logic)
2. 📱 Flutter quiz flow (UI + API integration)
3. 📊 Results dashboard API (analytics per user)
4. 📦 Postman full collection JSON file (import 1 click)

Chagua tuanze next level 🚀
