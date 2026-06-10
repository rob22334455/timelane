#!/usr/bin/env bash
# Serve Orgami locally at http://localhost:8000
cd "$(dirname "$0")"
PORT="${1:-8000}"
echo "Orgami → http://localhost:${PORT}  (Ctrl+C to stop)"
python3 -m http.server "$PORT"
