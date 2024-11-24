# Dockerfile for Backend (Flask app)

# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install dependencies
COPY backend/requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

# Copy the Flask app code
COPY backend/ /app/

# Expose port 5000 for Flask app
EXPOSE 5000

# Set environment variable for Flask
ENV FLASK_APP=${FLASK_APP}
ENV FLASK_RUN_HOST=0.0.0.0

# Run the Flask application
CMD ["flask", "run"]
