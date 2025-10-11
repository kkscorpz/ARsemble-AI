#!/bin/bash
pip install --upgrade pip setuptools wheel
pip install -r requirements.txt
python -m rasa train