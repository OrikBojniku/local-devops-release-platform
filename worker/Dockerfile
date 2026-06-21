# ---- Faza 1: Builder ----
FROM python:3.11-slim AS builder

WORKDIR /app

COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install --user --no-cache-dir -r requirements.txt

# ---- Faza 2: Production ----
FROM python:3.11-slim AS production

# Krijoni nje perdorues jo-root per siguri
RUN useradd --create-home --shell /bin/bash appuser

WORKDIR /app

# Kopjo varësitë e instaluara nga faza builder
COPY --from=builder /root/.local /home/appuser/.local

# Kopjo kodin
COPY worker.py .

# Kalon te perdoruesi jo-root
USER appuser

# Variablat e mjedisit
ENV PATH=/home/appuser/.local/bin:$PATH
ENV PYTHONUNBUFFERED=1

# Komanda per te startuar Worker-in
CMD ["python", "worker.py"]
