#!/bin/bash

ZSH_PATH=$(which zsh)
BASH_PATH=$(which bash)

if [ "$SHELL" = "$BASH_PATH" ]; then
  echo "The active shell is bash."
  PROFILE_FILE="$HOME/.bashrc"
  RAKUBREW_INIT='eval "$(/home/wolf/.rakubrew/bin/rakubrew init Bash)"'
elif [ "$SHELL" =  "$ZSH_PATH" ]; then
  echo "The active shell is zsh."
  PROFILE_FILE="$HOME/.zshenv"
  RAKUBREW_INIT='eval "$(/home/wolf/.rakubrew/bin/rakubrew init Zsh)"';
else
    echo "The active shell is neither bash nor zsh. ...skipping."
    exit 1
fi

# Create PROFILE_FILE if it doesn't exist
if [ ! -f "$PROFILE_FILE" ]; then
    touch "$PROFILE_FILE"
    echo "Created $PROFILE_FILE"
fi

# Check if the line already exists in the file
if ! grep -qF "$RAKUBREW_INIT" "$PROFILE_FILE"; then
    echo "$RAKUBREW_INIT" >> "$PROFILE_FILE"
    echo "Added rakubrew anitialization to $PROFILE_FILE"
else
    echo "Rakubrew initialization already exists in $PROFILE_FILE"
fi

# run initialization in current shell:
$("$RAKUBREW_INIT")

echo "Running 'rakubrew available'..."
rakubrew available

read -p "Enter the version you want to build: " version

echo "Building Rakudo MoarVM version $version..."
rakubrew build "moar-$version"

echo "Build zef"
rakubrew build-zef
