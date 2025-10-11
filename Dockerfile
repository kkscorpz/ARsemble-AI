# STEP 1: Use a standard Python 3.10 image as the base
FROM python:3.10-slim

# STEP 2: Install system dependencies needed to compile packages like PyYAML
# KRITIKAL: 'python3-dev' para sa compilation headers.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    python3-dev && \
    rm -rf /var/lib/apt/lists/*

# STEP 3: Set environment variables for Rasa and ports
ENV PYTHONUNBUFFERED=1 \
    RASA_PORT=5005 \
    ACTION_SERVER_PORT=5055

EXPOSE 5005
EXPOSE 5055

# STEP 4: Set the working directory for the application
WORKDIR /app

# STEP 5: Copy requirements file and install Python dependencies
# Ang pag-upgrade sa PyYAML sa 6.0.1 ay dapat na mag-ayos ng Cython build error.
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# STEP 6: Copy the rest of your project files
COPY . /app

# STEP 7: Train the model (recommended during the build process)
RUN rasa train

# STEP 8: Define the command to run the Rasa web server
CMD ["rasa", "run", "--enable-api", "--cors", "*", "-p", "5005"]
