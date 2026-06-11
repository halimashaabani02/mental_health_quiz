
## Register Users:
```
curl -X POST http://localhost/mental_health_quiz/api/users/register.php -H "Content-Type: application/json" -d '{ "username": "john_doee", "email": "johnn@example.com","password": "secret124","role": "user"}'

curl -X POST http://localhost/mental_health_quiz/api/auth/register.php -H "Content-Type: application/json" -d '{"username":"john_doe","email":"john@example.com","password":"secret123","role":"user"}'


http://localhost/mental_health_quiz/api/auth/
```

## Login
```

curl -X POST http://localhost/mental_health_quiz/api/auth/login.php -H "Content-Type: application/json" -d '{"email": "john@example.com", "password": "secret123"}'

```

## Get UserByID

```
curl -X GET "http://localhost/mental_health_quiz/api/users/get.php?id=1"
curl -X GET "http://localhost/mental_health_quiz/api/users/get.php?id=1"
```

## Get All Users

```
curl -X GET http://localhost/mental_health_quiz/api/users/list.php
curl -X GET http://localhost/mental_health_quiz/api/users/list.php
```

## Update UserByID

```
curl -X PUT http://localhost/mental_health_quiz/api/users/update.php -H "Content-Type: application/json" -d '{ "id": 1, "username": "john_updated", "email": "john_updated@example.com"}'
curl -X PUT http://localhost/mental_health_quiz/api/users/update.php -H "Content-Type: application/json" -d '{ "id": 3, "username": "john_updated", "email": "john_updated@example.com"}'

```


## Dellete UserByID

```
curl -X DELETE http://localhost/mental_health_quiz/api/users/delete.php -H "Content-Type: application/json" -d '{ "id": 3}'
```
