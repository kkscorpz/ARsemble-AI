#!/bin/bash
pip install --upgrade pip setuptools wheel

# Install Rasa first, then other dependencies
pip install rasa==3.5.15
pip install rasa-sdk==3.5.2

python -m rasa train