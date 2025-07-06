<?php
include '../includes/auth.php';
include '../includes/config.php';

// Ambil data user dari API
$opts = ['http' => ['header' => "Authorization: Bearer {$_SESSION['token']}"]];
$context = stream_context_create($opts);
$response = file_get_contents(API_BASE_URL . "/api/admin/users", false, $context);
$users = json_decode($response, true);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Data Users</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-5">
    <h2 class="mb-4">Data Pengguna</h2>

    <table class="table table-bordered">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Nama</th>
                <th>Email</th>
                <th>Admin?</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($users as $user): ?>
                <tr>
                    <td><?= htmlspecialchars($user['id']) ?></td>
                    <td><?= htmlspecialchars($user['name']) ?></td>
                    <td><?= htmlspecialchars($user['email']) ?></td>
                    <td><?= $user['is_admin'] ? '✔️' : '❌' ?></td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>

    <a href="../index.php" class="btn btn-secondary">Kembali ke Dashboard</a>
</body>
</html>
