#!/usr/bin/zsh

set -e

if [[ ! $1 ]]
then
    echo must be run as "./package.sh charts/<chart name>"
    echo 1
fi

alias helm=/home/sebastien/Desktop/helm
helm package $1 -d docs/
cp README.md .README.md
git checkout gh-pages
git pull
# TODO do check version
git checkout -b update-packages || git checkout update-packages
helm repo index docs --url https://eagle-one1.github.io/helm-charts/
mv .README.md README.md
git add README.md
git add docs
git commit -m "Release chart $1 version"
git push --set-upstream origin update-packages
git checkout main
git branch -D update-packages
# TODO sync README.md
