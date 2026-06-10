<?php
// api/submissions/get.php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');

require_once '../../config/Database.php';
require_once '../../classes/Submission.php';

$database = new Database();
$db = $database->connect();

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if (isset($_GET['id'])) {
        $submission = new Submission($db);
        $submission->id = $_GET['id'];
        $result = $submission->getById();
        echo json_encode($result);
    } else {
        echo json_encode(['success' => false, 'message' => 'Submission ID is required']);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Only GET requests allowed']);
}

$database->close();
?>
