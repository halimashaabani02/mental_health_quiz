<?php
// classes/Question.php
class Question {
    private $conn;
    private $table = 'questions';

    public $id;
    public $question_text;
    public $created_at;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Get question by ID
    public function getById() {
        $query = "SELECT id, question_text, created_at FROM " . $this->table . " WHERE id = ?";
        
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
            return ['success' => false, 'message' => 'Question not found'];
        }
    }

    // Get all questions
    public function getAll() {
        $query = "SELECT id, question_text, created_at FROM " . $this->table . " ORDER BY id ASC";
        
        $result = $this->conn->query($query);

        if (!$result) {
            return ['success' => false, 'message' => 'Query failed: ' . $this->conn->error];
        }

        $questions = [];
        while ($row = $result->fetch_assoc()) {
            $questions[] = $row;
        }

        return [
            'success' => true,
            'count' => count($questions),
            'data' => $questions
        ];
    }

    // Create question
    public function create() {
        $query = "INSERT INTO " . $this->table . " 
                  (question_text) 
                  VALUES (?)";

        $stmt = $this->conn->prepare($query);

        if (!$stmt) {
            return ['success' => false, 'message' => 'Query prepare failed: ' . $this->conn->error];
        }

        $stmt->bind_param("s", $this->question_text);

        if ($stmt->execute()) {
            return ['success' => true, 'message' => 'Question created successfully', 'id' => $this->conn->insert_id];
        } else {
            return ['success' => false, 'message' => 'Error creating question: ' . $stmt->error];
        }
    }

    // Update question
    public function update() {
        $query = "UPDATE " . $this->table . " 
                  SET question_text = ? 
                  WHERE id = ?";

        $stmt = $this->conn->prepare($query);

        if (!$stmt) {
            return ['success' => false, 'message' => 'Query prepare failed: ' . $this->conn->error];
        }

        $stmt->bind_param("si", $this->question_text, $this->id);

        if ($stmt->execute()) {
            return ['success' => true, 'message' => 'Question updated successfully'];
        } else {
            return ['success' => false, 'message' => 'Error updating question: ' . $stmt->error];
        }
    }

    // Delete question
    public function delete() {
        $query = "DELETE FROM " . $this->table . " WHERE id = ?";
        
        $stmt = $this->conn->prepare($query);

        if (!$stmt) {
            return ['success' => false, 'message' => 'Query prepare failed: ' . $this->conn->error];
        }

        $stmt->bind_param("i", $this->id);

        if ($stmt->execute()) {
            return ['success' => true, 'message' => 'Question deleted successfully'];
        } else {
            return ['success' => false, 'message' => 'Error deleting question: ' . $stmt->error];
        }
    }
}
?>
