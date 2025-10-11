#!/bin/bash
python -m rasa run \
  --port $PORT \
  --credentials credentials.yml \
  --endpoints endpoints.yml \
  --enable-api \
  --cors "*" \
  --debug