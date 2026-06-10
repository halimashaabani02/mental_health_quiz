<?php
// classes/Answer.php
class Answer {
    private $conn;
    private $table = 'answers';

    public $id;
    public $question_id;
    public $answer_text;
    public $is_correct;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Get answer by ID
    public function getById() {
        $query = "SELECT id, question_id, answer_text, is_correct FROM " . $this->table . " WHERE id = ?";
        
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
            return ['success' => false, 'message' => 'Answer not found'];
        }
    }

    // Get answers by question ID
    public function getByQuestionId() {
        $query = "SELECT id, question_id, answer_text, is_correct FROM " . $this->table . " WHERE question_id = ?";
        
        $stmt = $this->conn->prepare($query);
        
        if (!$stmt) {
            return ['success' => false, 'message' => 'Query prepare failed: ' . $this->conn->error];
        }

        $stmt->bind_param("i", $this->question_id);
        $stmt->execute();
        $result = $stmt->get_result();

        $answers = [];
        while ($row = $result->fetch_assoc()) {
            $answers[] = $row;
        }

        return [
            'success' => true,
            'count' => count($answers),
            'data' => $answers
        ];
    }

    // Get all answers
    public function getAll() {
        $query = "SELECT id, question_id, answer_text, is_correct FROM " . $this->table . " ORDER BY question_id ASC, id ASC";
        
        $result = $this->conn->query($query);

        if (!$result) {
            return ['success' => false, 'message' => 'Query failed: ' . $this->conn->error];
        }

        $answers = [];
        while ($row = $result->fetch_assoc()) {
            $answers[] = $row;
        }

        return [
            'success' => true,
            'count' => count($answers),
            'data' => $answers
        ];
    }

    // Create answer
    public function create() {
        $query = "INSERT INTO " . $this->table . " 
                  (question_id, answer_text, is_correct) 
                  VALUES (?, ?, ?)";

        $stmt = $this->conn->prepare($query);

        if (!$stmt) {
            return ['success' => false, 'message' => 'Query prepare failed: ' . $this->conn->error];
        }

        $stmt->bind_param("isi", $this->question_id, $this->answer_text, $this->is_correct);

        if ($stmt->execute()) {
            return ['success' => true, 'message' => 'Answer created successfully', 'id' => $this->conn->insert_id];
        } else {
            return ['success' => false, 'message' => 'Error creating answer: ' . $stmt->error];
        }
    }

    // Update answer
    public function update() {
        $query = "UPDATE " . $this->table . " 
                  SET answer_text = ?, is_correct = ? 
                  WHERE id = ?";

        $stmt = $this->conn->prepare($query);

        if (!$stmt) {
            return ['success' => false, 'message' => 'Query prepare failed: ' . $this->conn->error];
        }

        $stmt->bind_param("sii", $this->answer_text, $this->is_correct, $this->id);

        if ($stmt->execute()) {
            return ['success' => true, 'message' => 'Answer updated successfully'];
        } else {
            return ['success' => false, 'message' => 'Error updating answer: ' . $stmt->error];
        }
    }

    // Delete answer
    public function delete() {
        $query = "DELETE FROM " . $this->table . " WHERE id = ?";
        
        $stmt = $this->conn->prepare($query);

        if (!$stmt) {
            return ['success' => false, 'message' => 'Query prepare failed: ' . $this->conn->error];
        }

        $stmt->bind_param("i", $this->id);

        if ($stmt->execute()) {
            return ['success' => true, 'message' => 'Answer deleted successfully'];
        } else {
            return ['success' => false, 'message' => 'Error deleting answer: ' . $stmt->error];
        }
    }
}
?>
