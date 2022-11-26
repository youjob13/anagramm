#!/bin/bash

check_errcode() {
    status=$?

    if [ $status -ne 0 ]; then
        echo "${1}"
        exit $status
    fi
}

echo "Checking for missing dependencies before build..."

# Check if node_modules exists, if not throw an error
if [ ! -d "./node_modules" ] || [ ! -d "./angular-src/node_modules" ]; then
    echo "node_modules are missing! running install script..."
    npm ci
    echo "Installed all missing dependencies! starting installation..."
else
    echo "All dependencies are installed! Ready to run build!"
fi

# This script compiles typescript and Angular 7 application and puts them into a single NodeJS project
ENV=${NODE_ENV:-production}
echo -e "\n-- Started build script for Angular (environment $ENV) --"

echo "Compiling typescript..."
./node_modules/.bin/tsc -p ./tsconfig.app.json
check_errcode "Failed to compile typescript! aborting script!"

# echo "Copying configuration files..."
# cp -Rf src/config dist/src/config
# check_errcode "Failed to copy configuration files! aborting script!"

echo "Starting to configure Angular app..."

# pushd angular-src

echo "Building Angular app for $ENV..."
./node_modules/.bin/ng build
check_errcode "Failed to build angular! stopping script!"

# echo "Copying angular dist into dist directory..."
# mkdir ../dist/src/dist
# cp -Rf dist ../dist/src
# check_errcode "Failed to copy anuglar dist files! aborting script!"

# echo "Removing angular-src dist directory..."
# rm -rf dist

# Go back to the current directory
# popd
pwd
ls dist
ls dist/anagramm
echo "-- Finished building Angular & NodeJS, check dist directory --"