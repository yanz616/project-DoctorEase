<?php
include '../includes/auth.php';
include __DIR__ . '/../includes/config.php';

// Ambil data dokter
$opts = [
    'http' => [
        'header' => "Authorization: Bearer {$_SESSION['token']}"
    ]
];
$context = stream_context_create($opts);
$response = file_get_contents(API_BASE_URL . "/api/admin/doctors", false, $context);
$doctors = json_decode($response, true);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Doctors CRUD</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h2 class="mb-4">Manage Doctors</h2>
    <div class="d-flex justify-content-between mb-3">
        <a href="../index.php" class="btn btn-secondary">← Back</a>
        <a href="logout.php" class="btn btn-danger">Logout</a>
    </div>

    <!-- Button to Add Doctor -->
    <a href="create.php" class="btn btn-primary mb-3">+ Add Doctor</a>

    <table class="table table-bordered bg-white shadow">
        <thead class="table-dark">
            <tr>
                <th>Name</th>
                <th>Specialization</th>
                <th>Photo</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <?php foreach ($doctors as $doctor): ?>
            <tr>
                <td><?= htmlspecialchars($doctor['name']) ?></td>
                <td><?= htmlspecialchars($doctor['specialization']) ?></td>
                <td><img src="<?= !empty($doctor['photo_url']) ? $doctor['photo_url'] : 'https://via.placeholder.com/80' ?>" width="80"></td>
                <td>
                    <a href="update.php?id=<?= $doctor['id'] ?>" class="btn btn-sm btn-warning">Edit</a>
                    <a href="delete.php?id=<?= $doctor['id'] ?>" onclick="return confirm('Are you sure?')" class="btn btn-sm btn-danger">Delete</a>
                </td>
            </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
</div>

</body>
</html>
