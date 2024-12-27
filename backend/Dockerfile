# Backend Dockerfile
FROM python:3.9-slim

# Install dependencies and MySQL client
RUN apt-get update && \
    apt-get install -y \
    default-mysql-client \
    && rm -rf /var/lib/apt/lists/*
# Set working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY . /app/

ENV FLASK_ENV=$FLASK_ENV
ENV FLASK_APP=$FLASK_APP

# Expose the port
EXPOSE 5000

# Run the app
CMD ["flask", "run", "--host=0.0.0.0"]
