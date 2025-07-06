<?php
session_start();
include __DIR__ . '/includes/config.php';

if (isset($_SESSION['token'])) {
    $opts = [
        'http' => [
            'method' => 'POST',
            'header' => "Authorization: Bearer {$_SESSION['token']}"
        ]
    ];

    $context = stream_context_create($opts);
    @file_get_contents(API_BASE_URL . "/api/logout", false, $context);
}

session_destroy();  // hapus semua session

header("Location: login.php");
exit;
