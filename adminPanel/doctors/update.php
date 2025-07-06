<?php
include '../includes/auth.php';
include __DIR__ . '/../includes/config.php';

$id = $_GET['id'] ?? null;

if (!$id) {
    die("ID dokter tidak ditemukan.");
}

// Jika form disubmit (POST)
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = http_build_query([
        'name' => $_POST['name'],
        'specialization' => $_POST['specialization'],
        'photo_url' => $_POST['photo_url'],
    ]);

    $opts = [
        'http' => [
            'method' => 'PUT',
            'header' => "Authorization: Bearer {$_SESSION['token']}\r\nContent-Type: application/x-www-form-urlencoded",
            'content' => $data
        ]
    ];
    $context = stream_context_create($opts);

    $response = file_get_contents(API_BASE_URL . "/api/admin/doctors/$id", false, $context);

    header("Location: index.php");
    exit;
}

// Ambil data dokter berdasarkan ID
$opts = [
    'http' => [
        'header' => "Authorization: Bearer {$_SESSION['token']}"
    ]
];
$context = stream_context_create($opts);
$response = file_get_contents(API_BASE_URL . "/api/admin/doctors/$id", false, $context);
$doctor = json_decode($response, true);

// Jika dokter tidak ditemukan
if (!$doctor || isset($doctor['message'])) {
    die("Data dokter tidak ditemukan.");
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Dokter</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <h2 class="mb-4">Edit Dokter</h2>
    <form method="POST" class="w-50">
        <div class="mb-3">
            <label class="form-label">Nama</label>
            <input type="text" name="name" class="form-control" value="<?= htmlspecialchars($doctor['name']) ?>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Spesialisasi</label>
            <input type="text" name="specialization" class="form-control" value="<?= htmlspecialchars($doctor['specialization']) ?>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Foto URL</label>
            <input type="text" name="photo_url" class="form-control" value="<?= htmlspecialchars($doctor['photo_url']) ?>">
        </div>
        <button type="submit" class="btn btn-primary">Update</button>
        <a href="doctor.php" class="btn btn-secondary">Batal</a>
    </form>
</body>
</html>
