# Use the official Python image from the Docker Hub
FROM python:3.8-slim

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    chromium \
    chromium-driver

# Install Robot Framework and SeleniumLibrary
RUN pip install --upgrade pip
RUN pip install robotframework
RUN pip install robotframework-seleniumlibrary

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Create a directory for logs
RUN mkdir -p /app/logs

# Set environment variable for ChromeDriver
ENV CHROME_USER_DATA_DIR=/app/chrome-user-data

# Run the Robot Framework test and save logs
CMD ["robot", "--variable", "CHROME_USER_DATA_DIR:/app/chrome-user-data", "--outputdir", "logs", "test/test.robot"]