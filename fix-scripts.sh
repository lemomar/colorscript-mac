#!/usr/bin/env bash

# Function to fix a file
fix_file() {
    # Convert to Unix line endings
    tr -d '\r' < "$1" > "$1.tmp"
    mv "$1.tmp" "$1"
    # Make executable
    chmod +x "$1"
}

# Fix main scripts
fix_file "colorscript.sh"
fix_file "install.sh"
fix_file "fix-line-endings.sh"

# Fix all colorscripts
for script in colorscripts/*; do
    if [ -f "$script" ]; then
        fix_file "$script"
    fi
done

echo "All scripts have been fixed and made executable"