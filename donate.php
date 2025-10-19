<?php

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../controllers/AuthController.php';

// Initialize connection
$db = (new Database())->connect();
$auth = new AuthController($db);

// Get data from POST or JSON body


$data = json_decode(file_get_contents("php://input"), true);

$id = $data['id'] ?? $_POST['id'] ?? '';
$donate_type = $data['donate_type'] ?? $_POST['donate_type'] ?? '';
$amount = $data['amount'] ?? $_POST['amount'] ?? '';
$ref = $data['ref'] ?? $_POST['ref'] ?? '';


$auth->donate($id, $donate_type, $amount, $ref);




?>
