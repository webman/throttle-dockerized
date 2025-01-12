#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
NOCOLOR='\033[0m'

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo -e "${RED}Docker is not installed.${NOCOLOR}"
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker compose &> /dev/null; then
    echo -e "${RED}Docker Compose is not installed.${NOCOLOR}"
    exit 1
fi

# Run application containers
docker compose up --force-recreate --no-deps --no-build -d
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Containers launched successfully.${NOCOLOR}"
else
    echo -e "${RED}Failed to launch containers.${NOCOLOR}"
    exit 1
fi

# Install application dependencies
docker exec throttle composer install
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Application dependencies installed successfully.${NOCOLOR}"
else
    echo -e "${RED}Failed to install application dependencies.${NOCOLOR}"
    exit 1
fi

# Rollback phacility/libphutil dependency to working version (thanks to West14)
docker exec -it throttle sh -c "cd /var/www/throttle/vendor/phacility/libphutil && git reset --hard 39ed96cd818aae761ec92613a9ba0800824d0ab0"
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Dependency phacility/libphutil rolled back to working version.${NOCOLOR}"
else
    echo -e "${RED}Failed to rollback dependency phacility/libphutil to working version.${NOCOLOR}"
    exit 1
fi

# Run database migrations
docker exec throttle php app/console.php migrations:migrate
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Application migrations ran successfully.${NOCOLOR}"
else
    echo -e "${RED}Failed to run application migrations.${NOCOLOR}"
    exit 1
fi

# Change folder permissions
docker exec throttle chmod -R a+w logs cache dumps symbols/public
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Folder permissions changed successfully.${NOCOLOR}"
else
    echo -e "${RED}Failed to change folder permissions.${NOCOLOR}"
    exit 1
fi
