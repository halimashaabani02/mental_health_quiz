<?php
// config/Database.php
class Database {
    private $host = 'localhost';
    private $db_name = 'mental_health_quiz';
    private $user = 'root';
    private $password = '';
    private $conn;

    public function connect() {
        $this->conn = null;

        try {
            $this->conn = new mysqli(
                $this->host,
                $this->user,
                $this->password,
                $this->db_name
            );

            if ($this->conn->connect_error) {
                throw new Exception('Database Connection Error: ' . $this->conn->connect_error);
            }

            $this->conn->set_charset("utf8mb4");
        } catch (Exception $e) {
            echo json_encode(['success' => false, 'message' => $e->getMessage()]);
            exit;
        }

        return $this->conn;
    }

    public function close() {
        if ($this->conn) {
            $this->conn->close();
        }
    }
}
?>
