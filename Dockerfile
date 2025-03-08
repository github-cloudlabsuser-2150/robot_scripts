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
    && rm -rf /var/lib/apt/lists/*

# Install Chrome
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && \
    apt-get install -y google-chrome-stable

# Install ChromeDriver
RUN CHROME_VERSION=$(google-chrome --version | grep -oP '\d+\.\d+\.\d+') && \
    CHROMEDRIVER_VERSION=$(curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_VERSION) && \
    wget -N https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip -P /tmp && \
    unzip /tmp/chromedriver_linux64.zip -d /tmp && \
    rm /tmp/chromedriver_linux64.zip && \
    mv /tmp/chromedriver /usr/local/bin/chromedriver && \
    chown root:root /usr/local/bin/chromedriver && \
    chmod 0755 /usr/local/bin/chromedriver

# Install Robot Framework and SeleniumLibrary
RUN pip install --no-cache-dir robotframework robotframework-seleniumlibrary

# Copy the Robot Framework test cases into the container
COPY . /app

# Start xvfb and set the display environment variable
CMD ["sh", "-c", "Xvfb :99 -ac & export DISPLAY=:99 && robot --outputdir logs test/test.robot"]