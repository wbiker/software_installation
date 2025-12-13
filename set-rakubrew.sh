#!/usr/bin/bash

if [[ -n $BASH_VERSION ]]; then
  echo "BASH found"
    PROFILE_FILE="$HOME/.bashrc"
    RAKUBREW_INIT='eval "$(/home/wolf/.rakubrew/bin/rakubrew init Bash)"'
elif [[ -n $ZSH_VERSION ]]; then
  echo "ZSH found"
  PROFILE_FILE="$HOME/.zshenv"
  RAKUBREW_INIT='eval "$(/home/wolf/.rakubrew/bin/rakubrew init Zsh)"';
else
    echo "Unknown shell. Skipping..."
    exit 1
fi

# Check if the line already exists in the file
if ! grep -qF "$RAKUBREW_INIT" "$PROFILE_FILE"; then
    echo "$RAKUBREW_INIT" >> "$PROFILE_FILE"
    echo "Added rakubrew anitialization to $PROFILE_FILE"
else
    echo "Rakubrew initialization already exists in $PROFILE_FILE"
fi
