#!/bin/bash
set -e

# Passwort setzen (nur beim ersten Start)
if [ ! -f /etc/webmin/.docker_initialized ]; then
    echo "🛡️  Setting Webmin password for user 'root'"
    /usr/share/webmin/changepass.pl /etc/webmin root rootpass
    touch /etc/webmin/.docker_initialized
fi
