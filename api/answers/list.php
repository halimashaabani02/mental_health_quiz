<?php
// api/answers/list.php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');

require_once '../../config/Database.php';
require_once '../../classes/Answer.php';

$database = new Database();
$db = $database->connect();

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if (isset($_GET['question_id'])) {
        $answer = new Answer($db);
        $answer->question_id = $_GET['question_id'];
        $result = $answer->getByQuestionId();
    } else {
        $answer = new Answer($db);
        $result = $answer->getAll();
    }
    
    echo json_encode($result);
} else {
    echo json_encode(['success' => false, 'message' => 'Only GET requests allowed']);
}

$database->close();
?>
