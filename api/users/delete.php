<?php
// api/users/delete.php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: DELETE, POST');
header('Access-Control-Allow-Headers: Content-Type');

require_once '../../config/Database.php';
require_once '../../classes/User.php';

$database = new Database();
$db = $database->connect();

if ($_SERVER['REQUEST_METHOD'] === 'DELETE' || $_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents("php://input"));

    if (isset($data->id)) {
        $user = new User($db);
        $user->id = $data->id;

        $result = $user->delete();
        echo json_encode($result);
    } else {
        echo json_encode(['success' => false, 'message' => 'User ID is required']);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Only DELETE/POST requests allowed']);
}

$database->close();
?>
