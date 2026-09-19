#Requires -Version 5.1
Copy-Item -Path .env.example -Destination .env -ErrorAction SilentlyContinue
Write-Host "NEXUS: copied .env.example -> .env if missing. Edit secrets, then: docker compose up --build"
