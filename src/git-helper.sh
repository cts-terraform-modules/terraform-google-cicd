#!/bin/bash

set -e
cd ${LOCAL_REPO}
if [ ! -d ".git" ]
then
    git init
    git config --global credential.https://source.developers.google.com.helper gcloud.sh
    git remote add google ${URL}
    git add .
    git commit -m "Initial commit"
    git push -u google master
else
    arr=($(git remote show))
    pushed=false
    for r in ${arr[@]}
    do
        if [ $r == "google" ]
        then 
            pushed=true
        fi
    done
    if [ $pushed == "false" ]
    then
        git config --global credential.https://source.developers.google.com.helper gcloud.sh
        git remote add google ${URL}
        git push -u google master
    else
        echo "Repo already pushed."
    fi
fi