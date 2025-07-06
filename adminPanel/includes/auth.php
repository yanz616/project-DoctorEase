<?php
session_start();
include __DIR__ . '/config.php';
if (!isset($_SESSION['token'])) {
    header("Location: login.php");
    exit;
}

// Validasi apakah admin
$opts = [
    'http' => [
        'header' => "Authorization: Bearer {$_SESSION['token']}"
    ]
];
$context = stream_context_create($opts);
$userJson = @file_get_contents(API_BASE_URL . "/api/user", false, $context);
$user = json_decode($userJson, true);

if (empty($user) || !$user['is_admin']) {
    echo "Akses ditolak. Anda bukan admin.";
    exit;
}
?>
