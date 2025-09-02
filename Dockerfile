FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    DJANGO_SETTINGS_MODULE=vegefruits_ecommerce.settings \
    PYTHONPATH="/app"

WORKDIR /app

# System deps for Pillow & friends
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential gcc \
    libjpeg-dev zlib1g-dev libpng-dev libtiff-dev libfreetype6-dev \
    liblcms2-dev libopenjp2-7-dev libwebp-dev \
    ca-certificates curl && \
    rm -rf /var/lib/apt/lists/*

# Install Python deps
COPY requirements.txt .
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

# Copy project
COPY . .

# Non-root user & writable dirs for media/db
RUN useradd -m app && mkdir -p /app/staticfiles /app/media /data && \
    chown -R app:app /app /data
USER app

EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
