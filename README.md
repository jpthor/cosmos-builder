# Cosmos Builder

## Overview

This tool allows new developers to get up and running with a CosmosSDK Application fast.

A simple CLI builder walks you through the process of setting up the application with the following customisations:

- Application Path
- Application Name
- Service Name and Abbreviation
- Token Name

The application is a simple property registry where ownership is unique (think DNS, inventory, house or vehicle registry). This serves as an excellent starting point to building your own application.

The following transaction types will be created in the process:

- New: creates a new property entry to store in state
- Set: updates the name of the property entry
- Get: queries the stored state
- Buy: update the owner of the entry with a corresponding transaction

## Starting

For the first time run `chmod 777 new.sh` to set permissions to run the script.

Then run `./new.sh` to start it.

When the app has been build and refactored, config and start the daemon by running:

`chmod 777 start.sh && ./start.sh`

## TODO

- Complete the refactoring
- Allow setting of new store types (set, get)
- Port to GoLang
- Connect to Swagger
- Connect to a local blockchain explorer
