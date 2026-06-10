<?php
// classes/SubmissionDetail.php
class SubmissionDetail {
    private $conn;
    private $table = 'submission_details';

    public $id;
    public $submission_id;
    public $question_id;
    public $selected_answer_id;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Create submission detail
    public function create() {
        $query = "INSERT INTO " . $this->table . " 
                  (submission_id, question_id, selected_answer_id) 
                  VALUES (?, ?, ?)";

        $stmt = $this->conn->prepare($query);

        if (!$stmt) {
            return ['success' => false, 'message' => 'Query prepare failed: ' . $this->conn->error];
        }

        $stmt->bind_param("iii", $this->submission_id, $this->question_id, $this->selected_answer_id);

        if ($stmt->execute()) {
            return ['success' => true, 'message' => 'Submission detail created successfully', 'id' => $this->conn->insert_id];
        } else {
            return ['success' => false, 'message' => 'Error creating submission detail: ' . $stmt->error];
        }
    }

    // Get submission details by submission ID
    public function getBySubmissionId() {
        $query = "SELECT sd.id, sd.submission_id, sd.question_id, q.question_text, 
                         sd.selected_answer_id, a.answer_text, a.is_correct
                  FROM " . $this->table . " sd
                  JOIN questions q ON sd.question_id = q.id
                  JOIN answers a ON sd.selected_answer_id = a.id
                  WHERE sd.submission_id = ?
                  ORDER BY sd.question_id ASC";
        
        $stmt = $this->conn->prepare($query);
        
        if (!$stmt) {
            return ['success' => false, 'message' => 'Query prepare failed: ' . $this->conn->error];
        }

        $stmt->bind_param("i", $this->submission_id);
        $stmt->execute();
        $result = $stmt->get_result();

        $details = [];
        while ($row = $result->fetch_assoc()) {
            $details[] = $row;
        }

        return [
            'success' => true,
            'count' => count($details),
            'data' => $details
        ];
    }

    // Get all submission details
    public function getAll() {
        $query = "SELECT sd.id, sd.submission_id, sd.question_id, q.question_text, 
                         sd.selected_answer_id, a.answer_text, a.is_correct
                  FROM " . $this->table . " sd
                  JOIN questions q ON sd.question_id = q.id
                  JOIN answers a ON sd.selected_answer_id = a.id
                  ORDER BY sd.submission_id DESC, sd.question_id ASC";
        
        $result = $this->conn->query($query);

        if (!$result) {
            return ['success' => false, 'message' => 'Query failed: ' . $this->conn->error];
        }

        $details = [];
        while ($row = $result->fetch_assoc()) {
            $details[] = $row;
        }

        return [
            'success' => true,
            'count' => count($details),
            'data' => $details
        ];
    }

    // Delete submission detail
    public function delete() {
        $query = "DELETE FROM " . $this->table . " WHERE id = ?";
        
        $stmt = $this->conn->prepare($query);

        if (!$stmt) {
            return ['success' => false, 'message' => 'Query prepare failed: ' . $this->conn->error];
        }

        $stmt->bind_param("i", $this->id);

        if ($stmt->execute()) {
            return ['success' => true, 'message' => 'Submission detail deleted successfully'];
        } else {
            return ['success' => false, 'message' => 'Error deleting submission detail: ' . $stmt->error];
        }
    }
}
?>
