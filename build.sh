#!/bin/bash
pip install --upgrade pip
pip install -r requirements.txt

# Train the Rasa model
python -m rasa train