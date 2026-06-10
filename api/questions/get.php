<?php
// api/questions/get.php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');

require_once '../../config/Database.php';
require_once '../../classes/Question.php';
require_once '../../classes/Answer.php';

$database = new Database();
$db = $database->connect();

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if (isset($_GET['id'])) {
        $question = new Question($db);
        $question->id = $_GET['id'];
        $result = $question->getById();
        
        if ($result['success']) {
            // Add answers to the question
            $answer = new Answer($db);
            $answer->question_id = $_GET['id'];
            $answers_result = $answer->getByQuestionId();
            $result['answers'] = $answers_result['data'] ?? [];
        }
        
        echo json_encode($result);
    } else {
        echo json_encode(['success' => false, 'message' => 'Question ID is required']);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Only GET requests allowed']);
}

$database->close();
?>
