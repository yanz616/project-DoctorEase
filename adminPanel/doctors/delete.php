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
file_get_contents(API_BASE_URL . "/api/admin/doctors/$id", false, $context);

header("Location: index.php");
exit;
