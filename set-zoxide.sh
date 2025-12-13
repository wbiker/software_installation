#!/bin/bash

if [ -n "${BASH_VERSION}" ]; then
  echo "BASH found"
    PROFILE_FILE="$HOME/.bashrc"
    ZOXIDE_INIT='eval "$(zoxide init --cmd cd bash)"'
elif [ -n "${ZSH_VERSION}" ]; then
  echo "ZSH found"
  PROFILE_FILE="$HOME/.zshrc"
  ZOXIDE_INIT='eval "$(zoxide init --cmd cd zsh)"';
else
    echo "Current shell is not bash. Skipping..."
    exit 1
fi

# Create PROFILE_FILE if it doesn't exist
if [ ! -f "$PROFILE_FILE" ]; then
    touch "$PROFILE_FILE"
    echo "Created $PROFILE_FILE"

fi

if [ -n "$BASH_VERSION" ]; then
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
