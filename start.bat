@echo off
echo Menjalankan Laravel Backend di 127.0.0.1:8000...
start cmd /k "cd Doctor-Ease-BE && php artisan serve --host=127.0.0.1 --port=8000"

@REM timeout /t 2

@REM echo Menjalankan Admin Panel PHP di 127.0.0.1:8080...
@REM start cmd /k "cd adminPanel && php -S 127.0.0.1:8080"

timeout /t 2

echo Menjalankan Flutter Frontend...
start cmd /k "cd doctor_ease_fe && flutter run"

exit
