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

# Create a Conky directory in the user's configuration directory
CONKY_CONFIG_DIR="$HOME_DIR/.config/conky"
mkdir -p "$CONKY_CONFIG_DIR"

# Copy the Conky configuration file to the Conky directory
cp "timekeeper_conky.conf" "$CONKY_CONFIG_DIR/timekeeper_conky.conf"

# Create a desktop entry file for autostart
DESKTOP_FILE="$HOME_DIR/.config/autostart/timekeeperconky.desktop"
echo "[Desktop Entry]
Name=Timekeeper Conky
Exec=$CONKY_EXECUTABLE -c $CONKY_CONFIG_DIR/timekeeper_conky.conf
Type=Application" > "$DESKTOP_FILE"

# Set executable permissions for the desktop entry file
chmod +x "$DESKTOP_FILE"

echo "Timekeeper Conky configuration and fonts installed successfully."
