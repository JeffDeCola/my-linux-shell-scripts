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
    tput setaf 2; echo "***** ALL SET - Nothing to commit, working tree clean"; tput sgr0
    exit 1
fi

# STEP 1 -  GIT ADD ------------------------------------------------------

tput setaf 4; echo "-- git add ."; tput sgr0
git add . 2>&1 | grep 'not a git repository'
if [ $? -ne 1 ]; then
    tput setaf 1; echo "***** ERROR - with git add"; tput sgr0
fi
echo ""

exit 1

# STEP 2 -  GIT COMMIT ---------------------------------------------------
tput setaf 4; echo "-- git commit -m \"$comment\""; tput sgr0
# git commit -m "$comment" 2>&1
if [ $? -ne 1 ]; then
    tput setaf 1; echo "***** ERROR - with git commit"; tput sgr0
fi
echo ""

# STEP 3 -  GIT PUSH -----------------------------------------------------
tput setaf 4; echo "-- git push (develop)"; tput sgr0
# If we push something, add to summary.
git push 2>&1 | grep 'Everything up-to-date'
# grep returns exit status ($?) 0 for a match
# Make stderr goto stdout 2>&1
if [ $? -ne 1 ]; then
    tput setaf 1; echo "***** ERROR - with git push"; tput sgr0
fi

# STEP 4 -  GH PR CREATE -------------------------------------------------


# STEP 5 -  GH PR MERGE --------------------------------------------------
