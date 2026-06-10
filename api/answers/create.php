<?php
// api/answers/create.php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

require_once '../../config/Database.php';
require_once '../../classes/Answer.php';

$database = new Database();
$db = $database->connect();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents("php://input"));

    if (isset($data->question_id) && isset($data->answer_text)) {
        $answer = new Answer($db);
        $answer->question_id = $data->question_id;
        $answer->answer_text = $data->answer_text;
        $answer->is_correct = $data->is_correct ?? 0;

        $result = $answer->create();
        echo json_encode($result);
    } else {
        echo json_encode(['success' => false, 'message' => 'Missing required fields']);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Only POST requests allowed']);
}

$database->close();
?>
