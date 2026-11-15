#!/bin/sh
set -e

alembic upgrade head
python -m app.cli seed-locations

python -m app.cli seed-content

exec uvicorn app.main:app \
    --host 0.0.0.0 \
    --port 8000 \
    --workers "${WEB_CONCURRENCY:-2}" \
    --proxy-headers \
    --no-server-header \
    --forwarded-allow-ips '*'