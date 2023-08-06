#!/bin/bash

# Check if conky is installed
CONKY_EXECUTABLE=$(command -v conky)
if [[ -z $CONKY_EXECUTABLE ]]; then
    echo "Conky is not installed. Please install Conky and try again."
    exit 1
fi

# Get the user's home directory
HOME_DIR=$(eval echo ~$USER)

# Font directory
FONT_DIR="$HOME_DIR/.local/share/fonts"

# Install fonts
if [[ -d "fonts" ]]; then
    echo "Installing fonts..."
    mkdir -p "$FONT_DIR"
    cp -R "fonts/"* "$FONT_DIR"
    fc-cache -f "$FONT_DIR"
    echo "Fonts installed successfully."
else
    echo "Fonts directory not found. Skipping font installation."
fi

mkdir ~/.conky
cp timekeeper_conky.conf ~/.conky

# Define the line you want to add to the .profile file
LINE_TO_ADD="conky -c ~/.conky/timekeeper_conky.conf"

# Check if .profile file exists in the home directory
if [ -f "$HOME/.profile" ]; then
    # Add the line to the .profile file if it's not already there
    if ! grep -q "$LINE_TO_ADD" "$HOME/.profile"; then
        echo "Adding the line to .profile..."
        echo "$LINE_TO_ADD" >> "$HOME/.profile"
        echo "Line added successfully!"
    else
        echo "The line is already present in .profile."
    fi
else
    # If .profile doesn't exist, create it and add the line
    echo "Creating .profile and adding the line..."
    echo "$LINE_TO_ADD" > "$HOME/.profile"
    echo ".profile created, and the line added successfully!"
fi

echo "Timekeeper Conky configuration and fonts installed successfully."
