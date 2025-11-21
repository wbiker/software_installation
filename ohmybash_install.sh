#!/bin/bash

if [ -n "$BASH_VERSION" ]; then
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
else
    echo "Current shell is not bash. Skipping..."
    exit 1
fi



