#!/bin/bash

# Check if the current shell is bash
if [ -n "$BASH_VERSION" ]; then
    # Define the profile file path
    PROFILE_FILE="$HOME/.bash_profile"
    
    # String to add
    ZOXIDE_INIT='eval "$(zoxide init --cmd cd bash)"'
    
    # Create .bash_profile if it doesn't exist
    if [ ! -f "$PROFILE_FILE" ]; then
        touch "$PROFILE_FILE"
        echo "Created $PROFILE_FILE"

        # source .bashrc. needed for oh-my-bash
        if [[ -f ~/.bashrc ]]; then
          source ~/.bashrc
        fi
    fi
    
    # Check if the line already exists in the file
    if ! grep -qF "$ZOXIDE_INIT" "$PROFILE_FILE"; then
        # Add the line to the file
        echo "$ZOXIDE_INIT" >> "$PROFILE_FILE"
        echo "Added zoxide initialization to $PROFILE_FILE"
    else
        echo "Zoxide initialization already exists in $PROFILE_FILE"
    fi
else
    echo "Current shell is not bash. Skipping..."
    exit 1
fi
