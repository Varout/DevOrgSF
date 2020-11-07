@echo off
REM Start the Lightning Web Component Local Devevelopment Server
echo Starting LWC Local Development Server
echo The server can be accessed at localhost:3333
echo The server will not start successfully unless the command is run
echo in a VS Code Salesforce development folder
echo Running: sfdx force:lightning:lwc:start
sfdx force:lightning:lwc:start
PAUSE