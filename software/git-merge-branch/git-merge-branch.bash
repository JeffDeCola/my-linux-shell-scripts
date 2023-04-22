#!/bin/bash
# my-linux-shell-scripts git-merge-branch.sh

# CHECK FOR AND ARGUMENT GIT COMMIT COMMENT
if [[ ("$#" == 0) || ("$#" -gt 1) ]]
  then
    # tput will make it red
    tput setaf 1; echo "***** ERROR - Must supply git commit comment in quotes"; tput sgr0
    exit 1
fi
comment=$1

# CHECK IS YOU NEED TO DO ANYTHING
git status 2>&1 | grep 'nothing to commit, working tree clean'
if [ $? -ne 1 ]; then
    tput setaf 4; echo "***** ALL SET - Nothing to commit, working tree clean"; tput sgr0
    exit 1
fi

# STEP 1 - GIT ADD ------------------------------------------------------
tput setaf 4; echo "-- git add ."; tput sgr0
git add . 2>&1 | grep 'not a git repository'
if [ $? -ne 1 ]; then
    tput setaf 1; echo "***** ERROR - with git add"; tput sgr0
fi

# STEP 2 - GIT COMMIT ---------------------------------------------------
tput setaf 4; echo "-- git commit -m \"$comment\""; tput sgr0
git commit -m "$comment"

# STEP 3 - GIT PUSH -----------------------------------------------------
tput setaf 4; echo "-- git push"; tput sgr0
git push

# STEP 4 - GH PR CREATE -------------------------------------------------
tput setaf 4; echo "-- gh pr create --fill"; tput sgr0
gh pr create --fill

# STEP 5 - GH PR MERGE --------------------------------------------------
tput setaf 4; echo "-- gh pr merge -m"; tput sgr0
gh pr merge -m
