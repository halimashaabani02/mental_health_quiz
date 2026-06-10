<?php
// api/submissions/list.php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');

require_once '../../config/Database.php';
require_once '../../classes/Submission.php';

$database = new Database();
$db = $database->connect();

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $submission = new Submission($db);
    
    if (isset($_GET['user_id'])) {
        $submission->user_id = $_GET['user_id'];
        $result = $submission->getByUserId();
    } else {
        $result = $submission->getAll();
    }
    
    echo json_encode($result);
} else {
    echo json_encode(['success' => false, 'message' => 'Only GET requests allowed']);
}

$database->close();
?>
