#!/usr/bin/env bash

# 1. Update pip and setuptools to fix legacy install errors
/usr/local/bin/python -m pip install --upgrade pip setuptools

# 2. Install system packages required for C compilation
apt-get update
apt-get install -y build-essential python3-dev