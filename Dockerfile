# Use the official Python image as the base image
FROM python:3.10-slim

# Set the working directory
WORKDIR /app

# Install required packages
RUN apt-get update && \
    apt-get install -y \
    wget \
    curl \
    unzip \
    xvfb \
    libxi6 \
    libgconf-2-4 \
    gnupg \
    firefox-esr \
    && rm -rf /var/lib/apt/lists/*

# Install Geckodriver
RUN GECKODRIVER_VERSION=$(curl -sS https://api.github.com/repos/mozilla/geckodriver/releases/latest | grep 'tag_name' | cut -d\" -f4) && \
    wget -N https://github.com/mozilla/geckodriver/releases/download/$GECKODRIVER_VERSION/geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz -P /tmp && \
    tar -xzf /tmp/geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz -C /usr/local/bin && \
    rm /tmp/geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz && \
    chown root:root /usr/local/bin/geckodriver && \
    chmod 0755 /usr/local/bin/geckodriver

# Install Robot Framework and SeleniumLibrary
RUN pip install --no-cache-dir robotframework robotframework-seleniumlibrary

# Copy the Robot Framework test cases into the container
COPY . /app

# Start xvfb and set the display environment variable
CMD ["sh", "-c", "Xvfb :99 -ac & export DISPLAY=:99 && robot --outputdir logs test/test.robot"]