<?php
include '../includes/auth.php';
include __DIR__ . '/../includes/config.php';

$id = $_GET['id'];

$opts = [
    'http' => [
        'method' => 'DELETE',
        'header' => "Authorization: Bearer {$_SESSION['token']}"
    ]
];
$context = stream_context_create($opts);
file_get_contents(API_BASE_URL . "/api/admin/appointments/$id", false, $context);

// ⬇️ Redirect setelah delete
header("Location: index.php");
exit;
