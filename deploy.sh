#!/bin/bash

# Load RVM into a shell session *as a function*
# NOTE: Not necessary if you already have a line similar to this in '~/.bash_profile'
[[ -s "/home/theashwanik/.rvm/scripts/rvm" ]] && source "/home/theashwanik/.rvm/scripts/rvm"  

# Create static site
bundle exec rake generate

# Publish site to GitHub
bundle exec rake deploy

# Fetch the optional commit message (as an argument)
if [[ -z "$1" ]]; then 
    message="Updated source `date`"
else
    message="$1"; 
fi

# Push the changes to 'source' to GitHub
echo ""
echo "## Commit source to GitHub"
git add .
git commit -a -m "$message"
git push origin source
