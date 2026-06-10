<?php
// api/submissions/create.php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

require_once '../../config/Database.php';
require_once '../../classes/Submission.php';
require_once '../../classes/SubmissionDetail.php';
require_once '../../classes/Answer.php';

$database = new Database();
$db = $database->connect();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents("php://input"));

    if (isset($data->user_id) && isset($data->answers)) {
        // Calculate score
        $correct_count = 0;
        $total_count = count($data->answers);
        
        $answer = new Answer($db);
        foreach ($data->answers as $ans) {
            $answer->id = $ans->answer_id;
            $answer_data = $answer->getById();
            if ($answer_data['success'] && $answer_data['data']['is_correct'] == 1) {
                $correct_count++;
            }
        }
        
        $score = ($correct_count / $total_count) * 100;
        
        // Generate feedback
        $feedback = '';
        if ($score >= 75) {
            $feedback = 'Hongera! Unaonyesha kuwa na afya imara ya akili. Endelea kujitunza!';
        } elseif ($score >= 50) {
            $feedback = 'Hongera! Upo karibu sana. Jaribu kujiangalia zaidi na kusoma zaidi kuhusu afya ya akili.';
        } else {
            $feedback = 'Karibu! Tafadhali kuamua kutembelea kwa mtaalam wa afya ya akili kwa ushauri zaidi.';
        }
        
        // Create submission
        $submission = new Submission($db);
        $submission->user_id = $data->user_id;
        $submission->score = (int)$score;
        $submission->feedback = $feedback;
        
        $result = $submission->create();
        
        if ($result['success']) {
            $submission_id = $result['id'];
            
            // Create submission details
            foreach ($data->answers as $ans) {
                $detail = new SubmissionDetail($db);
                $detail->submission_id = $submission_id;
                $detail->question_id = $ans->question_id;
                $detail->selected_answer_id = $ans->answer_id;
                $detail->create();
            }
            
            $result['score'] = (int)$score;
            $result['feedback'] = $feedback;
        }
        
        echo json_encode($result);
    } else {
        echo json_encode(['success' => false, 'message' => 'Missing required fields']);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Only POST requests allowed']);
}

$database->close();
?>
