#!/bin/bash

# Get the current branch name
git_branch=$(git rev-parse --abbrev-ref HEAD)

if [ "$git_branch" = "dev" ]; then
  # Build script for development environment
  sh './build.sh'
  
  # Docker login
  docker login -u aakashss -p dckr_pat_34-PWs-O163dyrKIzbzTPRuTXas
  
  # Tag and push the image to the development repository
  docker tag myreactapp:1.21.6-alpine aakashss/dev:myreactapp-1.21.6-alpine
  docker push aakashss/dev:myreactapp-1.21.6-alpine
else
  echo "Not on dev branch, skipping development environment setup."
fi

# Switch to the prod branch
git checkout prod

# Fetch latest changes from remote
git fetch

# Check if 'dev' branch is an ancestor of 'prod'
if git merge-base --is-ancestor dev HEAD; then
  # Deployment script for production environment
  sh './deploy.sh'
  
  # Docker login
  docker login -u aakashss -p dckr_pat_34-PWs-O163dyrKIzbzTPRuTXas
  
  # Tag and push the image to the production repository
  docker tag myreactapp:1.21.6-alpine aakashss/prod:myreactapp-1.21.6-alpine
  docker push aakashss/prod:myreactapp-1.21.6-alpine
else
  echo "dev not merged to prod, skipping production deployment."
fi

