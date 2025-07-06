@echo off
echo Menjalankan Laravel Backend di 0.0.0.0:8000...
start cmd /k "cd Doctor-Ease-BE && php artisan serve --host=0.0.0.0 --port=8000"

timeout /t 2

echo Menjalankan Admin Panel PHP di 192.168.1.18:8001...
start cmd /k "cd adminPanel && php -S 192.168.1.18:8001"

timeout /t 2

echo Menjalankan Flutter Frontend...
start cmd /k "cd doctor_ease_fe && flutter run"

exit
