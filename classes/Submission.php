<?php
// classes/Submission.php
class Submission {
    private $conn;
    private $table = 'submissions';

    public $id;
    public $user_id;
    public $score;
    public $feedback;
    public $submitted_at;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Create submission
    public function create() {
        $query = "INSERT INTO " . $this->table . " 
                  (user_id, score, feedback) 
                  VALUES (?, ?, ?)";

        $stmt = $this->conn->prepare($query);

        if (!$stmt) {
            return ['success' => false, 'message' => 'Query prepare failed: ' . $this->conn->error];
        }

        $stmt->bind_param("iis", $this->user_id, $this->score, $this->feedback);

        if ($stmt->execute()) {
            return ['success' => true, 'message' => 'Submission created successfully', 'id' => $this->conn->insert_id];
        } else {
            return ['success' => false, 'message' => 'Error creating submission: ' . $stmt->error];
        }
    }

    // Get submission by ID
    public function getById() {
        $query = "SELECT id, user_id, score, feedback, submitted_at FROM " . $this->table . " WHERE id = ?";
        
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
            return ['success' => false, 'message' => 'Submission not found'];
        }
    }

    // Get submissions by user ID
    public function getByUserId() {
        $query = "SELECT id, user_id, score, feedback, submitted_at FROM " . $this->table . " WHERE user_id = ? ORDER BY submitted_at DESC";
        
        $stmt = $this->conn->prepare($query);
        
        if (!$stmt) {
            return ['success' => false, 'message' => 'Query prepare failed: ' . $this->conn->error];
        }

        $stmt->bind_param("i", $this->user_id);
        $stmt->execute();
        $result = $stmt->get_result();

        $submissions = [];
        while ($row = $result->fetch_assoc()) {
            $submissions[] = $row;
        }

        return [
            'success' => true,
            'count' => count($submissions),
            'data' => $submissions
        ];
    }

    // Get all submissions
    public function getAll() {
        $query = "SELECT s.id, s.user_id, u.username, s.score, s.feedback, s.submitted_at 
                  FROM " . $this->table . " s
                  JOIN users u ON s.user_id = u.id
                  ORDER BY s.submitted_at DESC";
        
        $result = $this->conn->query($query);

        if (!$result) {
            return ['success' => false, 'message' => 'Query failed: ' . $this->conn->error];
        }

        $submissions = [];
        while ($row = $result->fetch_assoc()) {
            $submissions[] = $row;
        }

        return [
            'success' => true,
            'count' => count($submissions),
            'data' => $submissions
        ];
    }

    // Update submission
    public function update() {
        $query = "UPDATE " . $this->table . " 
                  SET score = ?, feedback = ? 
                  WHERE id = ?";

        $stmt = $this->conn->prepare($query);

        if (!$stmt) {
            return ['success' => false, 'message' => 'Query prepare failed: ' . $this->conn->error];
        }

        $stmt->bind_param("isi", $this->score, $this->feedback, $this->id);

        if ($stmt->execute()) {
            return ['success' => true, 'message' => 'Submission updated successfully'];
        } else {
            return ['success' => false, 'message' => 'Error updating submission: ' . $stmt->error];
        }
    }

    // Delete submission
    public function delete() {
        $query = "DELETE FROM " . $this->table . " WHERE id = ?";
        
        $stmt = $this->conn->prepare($query);

        if (!$stmt) {
            return ['success' => false, 'message' => 'Query prepare failed: ' . $this->conn->error];
        }

        $stmt->bind_param("i", $this->id);

        if ($stmt->execute()) {
            return ['success' => true, 'message' => 'Submission deleted successfully'];
        } else {
            return ['success' => false, 'message' => 'Error deleting submission: ' . $stmt->error];
        }
    }
}
?>
