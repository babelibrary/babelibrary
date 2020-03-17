#!/bin/sh

# If a command fails then the deploy stops
set -e

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

# Build the project.
hugo -d babelibrary.github.io # if using a theme, replace with `hugo -t <YOURTHEME>`

# Go To Public folder
cd babelibrary.github.io

# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master

# Now  update changes in the main repo <the site code>
cd ..

git add .

git commit -m "$msg"

git push origin master
