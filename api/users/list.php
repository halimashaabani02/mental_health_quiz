<?php
// api/users/list.php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');

require_once '../../config/Database.php';
require_once '../../classes/User.php';

$database = new Database();
$db = $database->connect();

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $user = new User($db);
    $result = $user->getAll();
    echo json_encode($result);
} else {
    echo json_encode(['success' => false, 'message' => 'Only GET requests allowed']);
}

$database->close();
?>
