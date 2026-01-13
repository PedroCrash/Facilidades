#!/bin/bash

# Define variables
CONFIG_DIR="./appsec-localconfig"
POLICY_URL="https://raw.githubusercontent.com/openappsec/open-appsec-npm/main/deployment/local_policy.yaml"
COMPOSE_URL="https://raw.githubusercontent.com/openappsec/open-appsec-npm/main/deployment/docker-compose.yaml"

echo "--- Starting open-appsec deployment ---"

# 1. Ask for user email
read -p "Enter the email address you wish to use: " USER_EMAIL

# 2. Create the local configuration directory
mkdir -p "$CONFIG_DIR"

# 3. Download the files
echo "Downloading configuration files..."
wget "$POLICY_URL" -O "$CONFIG_DIR/local_policy.yaml"
wget "$COMPOSE_URL" -O ./docker-compose.yaml

# 4. Replace the placeholder email in the docker-compose file
# This looks for 'user@email.com' and replaces it with the input variable
echo "Updating email in docker-compose.yaml to: $USER_EMAIL"
sed -i "s/user@email.com/$USER_EMAIL/g" ./docker-compose.yaml

# 5. Start the Docker containers
echo "Starting Docker containers..."
docker-compose up -d

echo "--- Deployment complete for $USER_EMAIL ---"