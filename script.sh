#!/bin/bash

set -x

# Set the repository URL
REPO_URL="https://89HbkCm2W0MIQuBnCly7L8eGlEmJ0p7BJeuCG1qgFcKHHpycvX3BJQQJ99BCACAAAAA0ARxSAAASAZDO4PZj@dev.azure.com/adityanavaneethan1998/Voting-App/_git/Voting-App"

# Clone the git repository into the /tmp directory
git clone "$REPO_URL" /tmp/temp_repo

# Navigate into the cloned repository directory
cd /tmp/temp_repo

# Make changes to the Kubernetes manifest file(s)
# For example, let's say you want to change the image tag in a deployment.yaml file
# $1 takes the filename like vote-deployment.yaml
# $2 takes the repository name like votingapp
# $3 takes the image tag that takes from the build tag
sed -i "s|image:.*|image: <ACR-REGISTRY-NAME>/$2:$3|g" k8s-specifications/$1-deployment.yaml
# sed -i "s|image:.*|image: votingappcontainers.azurecr.io/$2:$3|g" k8s-specifications/$1-deployment.yaml

# Add the modified files
git add .

# Commit the changes
git commit -m "Update Kubernetes manifest"

# Push the changes back to the repository
git push

# Cleanup: remove the temporary directory
rm -rf /tmp/temp_repo