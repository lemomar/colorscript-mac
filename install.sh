#!/usr/bin/env bash

# Create necessary directories
sudo mkdir -p /opt/shell-color-scripts/colorscripts
sudo mkdir -p /usr/local/bin

# Copy color scripts to /opt/shell-color-scripts/colorscripts
sudo cp ./colorscripts/* /opt/shell-color-scripts/colorscripts

# Make all scripts executable
sudo chmod +x /opt/shell-color-scripts/colorscripts/*

# Copy main script to /usr/local/bin
sudo cp ./colorscript.sh /usr/local/bin/colorscript
sudo chmod +x /usr/local/bin/colorscript

# Create zsh completion directory if it doesn't exist
sudo mkdir -p /usr/local/share/zsh/site-functions

# Copy zsh completion file
sudo cp ./zsh_completion/_colorscript /usr/local/share/zsh/site-functions/

echo "Installation completed!"
echo "You can now use the 'colorscript' command. Try 'colorscript --help' for usage information."