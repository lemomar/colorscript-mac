#!/bin/bash

# Function to fix shebang in a file
fix_shebang() {
    local file="$1"
    local tmp_file="$file.tmp"

    # Read first line
    read -r first_line < "$file"

    # Check if it's a shebang line
    if [[ $first_line == \#\!* ]]; then
        # Replace with /usr/bin/env bash
        echo '#!/usr/bin/env bash' > "$tmp_file"
        tail -n +2 "$file" >> "$tmp_file"
        mv "$tmp_file" "$file"
        chmod +x "$file"
    fi
}

# Fix main scripts
fix_shebang "colorscript.sh"
fix_shebang "install.sh"
fix_shebang "fix-scripts.sh"

# Fix all colorscripts
for script in colorscripts/*; do
    if [ -f "$script" ]; then
        fix_shebang "$script"
    fi
done

echo "All shebangs have been fixed"