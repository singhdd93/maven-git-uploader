#!/bin/sh 

display_usage() {
    echo "Upload the specified artifact to a git repo."
    echo "\nUsage:\n$0 groupId artifactId version packaging filePath repositoryId repositoryUrl\n"
    echo "\nRepo URL Syntax:\ngit:<branchname>://git@github.com:<username>/<reponame>.git\n"
}
if [ $# -lt 5 ]; then
    display_usage
    exit 1
fi

command -v mvn >/dev/null 2>&1 || { echo >&2 "mvn is required but it's not installed.  Aborting."; exit 1; }

if [[ ( $# == "--help") || $# == "-h" ]];then 
    display_usage
    exit 0
fi


if [ $# -eq 7 ]; then
    REPOSITORY_ID=$6
    REPOSITORY_URL=$7
fi

mvn deploy:deploy-file \
-DgroupId=$1 \
-DartifactId=$2 \
-Dversion=$3 \
-Dpackaging=$4 \
-Dfile=$5 \
-DrepositoryId=$6 \
-Durl=$7 \
-DuniqueVersion=false
