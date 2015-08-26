#!/bin/bash

# Clean up package folder
echo "[INFO] Cleaning up package directory"
ls -l
rm -rf *.properties
rm -rf artifacts
ls -l

# Clean up tmp directory
echo "[INFO] Cleaning up tmp directory"
cd /tmp
ls -l *${package_name}*.tar.gz
rm -rf *${package_name}*.tar.gz
ls -l

# Smoke test
# Get response from ping endpoint
echo "[INFO] Testing ping response: https://$dest_hostname:8443/ssg/ping" 
status=$(curl --silent --insecure --write-out "%{http_code}\\n" "https://$dest_hostname:8443/ssg/ping" -o /dev/null)
#echo $status

if [ $status -eq 200 ]
then
    echo "[INFO] Ping Response HTTP STATUS CODE: $status"
    exit 0
else
    echo "[ERROR] Ping Response HTTP STATUS CODE: $status. Failing test."
    exit 1
fi