FROM python:3.12-slim

WORKDIR /app

# Install dependencies first for better layer caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

EXPOSE 8080

# gunicorn is a production-grade WSGI server -- don't use Flask's dev server in prod
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "--workers", "2", "app:app"]
