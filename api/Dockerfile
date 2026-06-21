# ---- Faza 1: Builder ----
# Ketu instalojme varësitë - kjo fazë nuk shkon në prodhim
FROM python:3.11-slim AS builder

WORKDIR /app

# Kopjo dhe instalo varësitë
COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install --user --no-cache-dir -r requirements.txt

# ---- Faza 2: Production ----
# Ketu marrim vetem ate qe na duhet - imazhi final eshte i vogel
FROM python:3.11-slim AS production

# Krijoni nje perdorues jo-root per siguri
RUN useradd --create-home --shell /bin/bash appuser

WORKDIR /app

# Kopjo varësitë e instaluara nga faza builder
COPY --from=builder /root/.local /home/appuser/.local

# Kopjo kodin
COPY app.py .

# Kalon te perdoruesi jo-root
USER appuser

# Porta ku API dëgjon
EXPOSE 5000

# Variablat e mjedisit
ENV PATH=/home/appuser/.local/bin:$PATH
ENV PYTHONUNBUFFERED=1

# Komanda per te startuar API-n
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "2", "app:app"]
