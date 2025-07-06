<?php 
session_start();
include __DIR__ . '/includes/config.php';
 ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <h2>Admin Login</h2>
  <form method="POST" action="login.php">
    <div class="mb-3">
      <label>Email:</label>
      <input type="email" name="email" class="form-control" required>
    </div>
    <div class="mb-3">
      <label>Password:</label>
      <input type="password" name="password" class="form-control" required>
    </div>
    <button type="submit" name="login" class="btn btn-primary">Login</button>
  </form>

    <?php
  if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $payload = json_encode([
      "email" => $_POST['email'],
      "password" => $_POST['password']
    ]);

    $opts = [
      "http" => [
        "method" => "POST",
        "header" => "Content-Type: application/json",
        "content" => $payload
      ]
    ];

    $context = stream_context_create($opts);
    $response = @file_get_contents(API_BASE_URL . "/api/login", false, $context);

    if ($response === false) {
      echo "<p class='text-danger mt-3'>Login gagal. Periksa email/password.</p>";
    } else {
      $data = json_decode($response, true);
      $_SESSION['token'] = $data['token'];

      // cek apakah dia admin
      $opts['http']['method'] = "GET";
      $opts['http']['header'] .= "\r\nAuthorization: Bearer {$data['token']}";
      $context = stream_context_create($opts);
      $user = json_decode(file_get_contents(API_BASE_URL . "/api/user", false, $context), true);

      if ($user['is_admin']) {
        $_SESSION['is_admin'] = true;
        $_SESSION['user'] = $user;
        header("Location: index.php");
        exit;
      } else {
        echo "<p class='text-danger mt-3'>Anda bukan admin.</p>";
        session_destroy();
      }
    }
  }
  ?>
</body>
</html>