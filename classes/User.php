<?php
// classes/User.php
class User {
    private $conn;
    private $table = 'users';

    public $id;
    public $username;
    public $email;
    public $password;
    public $role;
    public $created_at;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Register new user
    public function register() {
        $query = "INSERT INTO " . $this->table . " 
                  (username, email, password, role) 
                  VALUES (?, ?, ?, ?)";

        $stmt = $this->conn->prepare($query);

        if (!$stmt) {
            return ['success' => false, 'message' => 'Query prepare failed: ' . $this->conn->error];
        }

        $hashed_password = password_hash($this->password, PASSWORD_BCRYPT);
        $role = $this->role ?? 'user';

        $stmt->bind_param("ssss", $this->username, $this->email, $hashed_password, $role);

        if ($stmt->execute()) {
            return ['success' => true, 'message' => 'User registered successfully', 'id' => $this->conn->insert_id];
        } else {
            return ['success' => false, 'message' => 'Error registering user: ' . $stmt->error];
        }
    }

    // Login user
    public function login() {
        $query = "SELECT id, username, email, password, role, created_at FROM " . $this->table . " WHERE email = ?";
        
        $stmt = $this->conn->prepare($query);
        
        if (!$stmt) {
            return ['success' => false, 'message' => 'Query prepare failed: ' . $this->conn->error];
        }

        $stmt->bind_param("s", $this->email);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows === 1) {
            $row = $result->fetch_assoc();
            if (password_verify($this->password, $row['password'])) {
                return [
                    'success' => true,
                    'message' => 'Login successful',
                    'user' => [
                        'id' => $row['id'],
                        'username' => $row['username'],
                        'email' => $row['email'],
                        'role' => $row['role'],
                        'created_at' => $row['created_at']
                    ]
                ];
            } else {
                return ['success' => false, 'message' => 'Invalid password'];
            }
        } else {
            return ['success' => false, 'message' => 'User not found'];
        }
    }

    // Get user by ID
    public function getById() {
        $query = "SELECT id, username, email, role, created_at FROM " . $this->table . " WHERE id = ?";
        
        $stmt = $this->conn->prepare($query);
        
        if (!$stmt) {
            return ['success' => false, 'message' => 'Query prepare failed: ' . $this->conn->error];
        }

        $stmt->bind_param("i", $this->id);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows === 1) {
            $row = $result->fetch_assoc();
            return [
                'success' => true,
                'data' => $row
            ];
        } else {
            return ['success' => false, 'message' => 'User not found'];
        }
    }

    // Get all users
    public function getAll() {
        $query = "SELECT id, username, email, role, created_at FROM " . $this->table . " ORDER BY created_at DESC";
        
        $result = $this->conn->query($query);

        if (!$result) {
            return ['success' => false, 'message' => 'Query failed: ' . $this->conn->error];
        }

        $users = [];
        while ($row = $result->fetch_assoc()) {
            $users[] = $row;
        }

        return [
            'success' => true,
            'count' => count($users),
            'data' => $users
        ];
    }

    // Update user
    public function update() {
        $query = "UPDATE " . $this->table . " 
                  SET username = ?, email = ? 
                  WHERE id = ?";

        $stmt = $this->conn->prepare($query);

        if (!$stmt) {
            return ['success' => false, 'message' => 'Query prepare failed: ' . $this->conn->error];
        }

        $stmt->bind_param("ssi", $this->username, $this->email, $this->id);

        if ($stmt->execute()) {
            return ['success' => true, 'message' => 'User updated successfully'];
        } else {
            return ['success' => false, 'message' => 'Error updating user: ' . $stmt->error];
        }
    }

    // Delete user
    public function delete() {
        $query = "DELETE FROM " . $this->table . " WHERE id = ?";
        
        $stmt = $this->conn->prepare($query);

        if (!$stmt) {
            return ['success' => false, 'message' => 'Query prepare failed: ' . $this->conn->error];
        }

        $stmt->bind_param("i", $this->id);

        if ($stmt->execute()) {
            return ['success' => true, 'message' => 'User deleted successfully'];
        } else {
            return ['success' => false, 'message' => 'Error deleting user: ' . $stmt->error];
        }
    }
}
?>
