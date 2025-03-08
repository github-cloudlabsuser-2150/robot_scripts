# Use the official Python image from the Docker Hub
FROM python:3.8-slim

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    chromium-driver

# Install Robot Framework and SeleniumLibrary
RUN pip install --upgrade pip
RUN pip install robotframework
RUN pip install robotframework-seleniumlibrary

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Run the Robot Framework test
CMD ["robot", "test/test.robot"]