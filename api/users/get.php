<?php
// api/users/get.php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');

require_once '../../config/Database.php';
require_once '../../classes/User.php';

$database = new Database();
$db = $database->connect();

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if (isset($_GET['id'])) {
        $user = new User($db);
        $user->id = $_GET['id'];
        $result = $user->getById();
        echo json_encode($result);
    } else {
        echo json_encode(['success' => false, 'message' => 'User ID is required']);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Only GET requests allowed']);
}

$database->close();
?>
