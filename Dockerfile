FROM python:3.10-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    python3-dev && \
    rm -rf /var/lib/apt/lists/*

# <<< FIX para sa cython_sources error >>>
RUN pip install --upgrade pip setuptools wheel

ENV PYTHONUNBUFFERED=1 \
    RASA_PORT=5005 \
    ACTION_SERVER_PORT=5055

EXPOSE 5005
EXPOSE 5055

WORKDIR /app

COPY requirements.txt ./
RUN pip install requirements.txt

COPY . /app

RUN rasa train


CMD ["rasa", "run", "--enable-api", "--cors", "*", "-p", "${PORT:-5005}"]