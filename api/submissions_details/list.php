<?php
// api/submission_details/list.php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');

require_once '../../config/Database.php';
require_once '../../classes/SubmissionDetail.php';

$database = new Database();
$db = $database->connect();

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if (isset($_GET['submission_id'])) {
        $detail = new SubmissionDetail($db);
        $detail->submission_id = $_GET['submission_id'];
        $result = $detail->getBySubmissionId();
    } else {
        $detail = new SubmissionDetail($db);
        $result = $detail->getAll();
    }
    
    echo json_encode($result);
} else {
    echo json_encode(['success' => false, 'message' => 'Only GET requests allowed']);
}

$database->close();
?>
