<?php
include '../includes/auth.php';
include __DIR__ . '/../includes/config.php';

// Ambil ID dari query string
$id = isset($_GET['id']) ? intval($_GET['id']) : 0;

if ($id <= 0) {
    echo "ID appointment tidak valid.";
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = http_build_query([
        'scheduled_at' => $_POST['scheduled_at'] ?? null,
        'purpose'      => $_POST['purpose'] ?? null,
        'status'       => $_POST['status'] ?? 'pending',
    ]);

    $opts = [
        'http' => [
            'method'  => 'PUT',
            'header'  => "Authorization: Bearer {$_SESSION['token']}\r\nContent-Type: application/x-www-form-urlencoded",
            'content' => $data,
        ]
    ];
    $context = stream_context_create($opts);
    $result = file_get_contents(API_BASE_URL . "/api/admin/appointments/$id", false, $context);

    if ($result === false) {
        echo "Gagal mengupdate appointment.";
    } else {
        header("Location: index.php");
        exit;
    }
}

// GET: Ambil detail appointment langsung by ID
$opts = ['http' => ['header' => "Authorization: Bearer {$_SESSION['token']}"]];
$context = stream_context_create($opts);
$response = file_get_contents(API_BASE_URL . "/api/admin/appointments/$id", false, $context);

if ($response === false) {
    echo "Gagal mengambil data appointment.";
    exit;
}

$appointment = json_decode($response, true);

if (!$appointment || !isset($appointment['id'])) {
    echo "Appointment dengan ID $id tidak ditemukan.";
    exit;
}
?>

<h2>Edit Appointment</h2>
<form method="POST">
    Status:
    <select name="status">
        <option value="pending" <?= $appointment['status'] == 'pending' ? 'selected' : '' ?>>Pending</option>
        <option value="approved" <?= $appointment['status'] == 'approved' ? 'selected' : '' ?>>Approved</option>
        <option value="canceled" <?= $appointment['status'] == 'canceled' ? 'selected' : '' ?>>Canceled</option>
        <option value="completed" <?= $appointment['status'] == 'completed' ? 'selected' : '' ?>>Completed</option>
    </select><br>
    <button type="submit">Update</button>
</form>
