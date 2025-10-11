#!/bin/bash
pip install --upgrade pip
pip install -r requirements.txt

# Download spacy model separately if needed
python -m spacy download en_core_web_md

# Train the Rasa model
python -m rasa train