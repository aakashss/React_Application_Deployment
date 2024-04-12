#!/bin/bash
git_branch=$(git rev-parse --abbrev-ref HEAD)
if [ "$git_branch" = "dev" ]; then
  sh './build.sh'
  docker login -u aakshss -p dckr_pat_34-PWs-O163dyrKIzbzTPRuTXas
  docker tag myreactapp:1.21.6-alpine aakahss/dev
  docker push aakashss/dev:myreactapp:1.21.6-alpine
else
  echo "not dev repo"
fi

git checkout prod
git fetch

if git merge-base --is-ancestor dev HEAD; then
  sh './deploy.sh'
  docker login -u aakashss -p dckr_pat_34-PWs-O163dyrKIzbzTPRuTXas
  docker tag myreactapp:1.21.6-alpine aakashss/prod
  docker push aakahsss/prod:myreactapp:1.21.6-alpine
else
  echo "dev not merged to prod"
fi
