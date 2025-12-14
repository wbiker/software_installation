#!/bin/bash

ZSH_PATH=$(which zsh)
BASH_PATH=$(which bash)

if [ "$SHELL" = "$BASH_PATH" ]; then
  echo "The active shell is bash."
  PROFILE_FILE="$HOME/.bashrc"
  ZOXIDE_INIT='eval "$(zoxide init --cmd cd bash)"'
elif [ "$SHELL" =  "$ZSH_PATH" ]; then
  echo "The active shell is zsh."
  PROFILE_FILE="$HOME/.zshrc"
  ZOXIDE_INIT='eval "$(zoxide init --cmd cd zsh)"';
else
    echo "The active shell is neither bash nor zsh. ...skipping."
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
