<?php
// api/questions/list.php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');

require_once '../../config/Database.php';
require_once '../../classes/Question.php';
require_once '../../classes/Answer.php';

$database = new Database();
$db = $database->connect();

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $question = new Question($db);
    $questions_result = $question->getAll();
    
    if ($questions_result['success']) {
        // Add answers to each question
        $answer = new Answer($db);
        foreach ($questions_result['data'] as &$q) {
            $answer->question_id = $q['id'];
            $answers_result = $answer->getByQuestionId();
            $q['answers'] = $answers_result['data'] ?? [];
        }
    }
    
    echo json_encode($questions_result);
} else {
    echo json_encode(['success' => false, 'message' => 'Only GET requests allowed']);
}

$database->close();
?>
