<?php
// api/users/update.php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: PUT, POST, PATCH');
header('Access-Control-Allow-Headers: Content-Type');

require_once '../../config/Database.php';
require_once '../../classes/User.php';

$database = new Database();
$db = $database->connect();

if ($_SERVER['REQUEST_METHOD'] === 'PUT' || $_SERVER['REQUEST_METHOD'] === 'POST' || $_SERVER['REQUEST_METHOD'] === 'PATCH') {
    $data = json_decode(file_get_contents("php://input"));

    if (isset($data->id) && isset($data->username) && isset($data->email)) {
        $user = new User($db);
        $user->id = $data->id;
        $user->username = $data->username;
        $user->email = $data->email;

        $result = $user->update();
        echo json_encode($result);
    } else {
        echo json_encode(['success' => false, 'message' => 'Missing required fields']);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Only PUT/POST/PATCH requests allowed']);
}

$database->close();
?>
