# STEP 1: Use a standard Python 3.10 image as the base
FROM python:3.10-slim

# STEP 2: Install system dependencies needed to compile packages like PyYAML
# 'build-essential' provides the C compiler (gcc) and other tools
RUN apt-get update && \
    apt-get install -y build-essential --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# STEP 3: Set environment variables for Rasa and ports
ENV PYTHONUNBUFFERED=1 \
    # Rasa runs on this port by default
    RASA_PORT=5005 \
    # The action server runs on this port
    ACTION_SERVER_PORT=5055
EXPOSE 5005
EXPOSE 5055

# STEP 4: Set the working directory for the application
WORKDIR /app

# STEP 5: Copy requirements file and install Python dependencies
# This is where your original error is fixed because 'build-essential' is now installed
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# STEP 6: Copy the rest of your project files
COPY . /app

# STEP 7: Train the model (recommended during the build process)
RUN rasa train
# Sa Dockerfile, bago ang RUN pip install...
RUN pip install Cython
# STEP 8: Define the command to run the Rasa web server
# This replaces the 'web' command in your Procfile
CMD [ "rasa", "run", "--enable-api", "--cors", "*", "-p", "5005" ]