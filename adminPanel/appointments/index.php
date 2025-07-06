<?php
include '../includes/auth.php';
include __DIR__ . '/../includes/config.php';

$opts = ['http' => ['header' => "Authorization: Bearer {$_SESSION['token']}"]];
$context = stream_context_create($opts);
$response = file_get_contents(API_BASE_URL . "/api/admin/appointments", false, $context);
$appointments = json_decode($response, true);
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Daftar Appointment</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="mb-4">Daftar Appointment</h2>

    <table class="table table-bordered table-striped">
        <thead class="table-dark">
            <tr>
                <th>User</th>
                <th>Dokter</th>
                <th>Jadwal</th>
                <th>Purpose</th>
                <th>Status</th>
                <th>Aksi</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($appointments as $a): ?>
            <tr>
                <td><?= htmlspecialchars($a['user']['name']) ?></td>
                <td><?= htmlspecialchars($a['doctor']['name']) ?></td>
                <td><?= htmlspecialchars($a['scheduled_at']) ?></td>
                <td><?= htmlspecialchars($a['purpose']) ?></td>
                <td><span class="badge bg-<?= getStatusColor($a['status']) ?>"><?= htmlspecialchars($a['status']) ?></span></td>
                <td>
                    <a href="update.php?id=<?= $a['id'] ?>" class="btn btn-sm btn-warning">Edit</a>
                    <a href="delete.php?id=<?= $a['id'] ?>" class="btn btn-sm btn-danger" onclick="return confirm('Yakin ingin menghapus?')">Hapus</a>
                </td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>

    <a href="../index.php" class="btn btn-secondary mt-3">Kembali ke Dashboard</a>
</div>
</body>
</html>

<?php
function getStatusColor($status) {
    return match ($status) {
        'pending' => 'secondary',
        'approved' => 'success',
        'completed' => 'primary',
        'canceled' => 'danger',
        default => 'light',
    };
}
?>
