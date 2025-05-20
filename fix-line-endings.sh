#!/bin/bash

# Convert all script files to Unix line endings
find . -type f -name "*.sh" -exec dos2unix {} \;
find ./colorscripts -type f -exec dos2unix {} \;