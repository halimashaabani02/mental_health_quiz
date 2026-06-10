<?php
// api/questions/create.php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

require_once '../../config/Database.php';
require_once '../../classes/Question.php';

$database = new Database();
$db = $database->connect();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents("php://input"));

    if (isset($data->question_text)) {
        $question = new Question($db);
        $question->question_text = $data->question_text;

        $result = $question->create();
        echo json_encode($result);
    } else {
        echo json_encode(['success' => false, 'message' => 'Question text is required']);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Only POST requests allowed']);
}

$database->close();
?>
