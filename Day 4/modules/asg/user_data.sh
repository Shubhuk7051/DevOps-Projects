#!/bin/bash

# Update package lists
sudo apt-get update

# Install Nginx
sudo apt-get install -y nginx

# Start Nginx service
sudo systemctl start nginx

# Enable Nginx to start on boot
sudo systemctl enable nginx

# Create a basic HTML file
echo "<!DOCTYPE html>
<html>
<head>
    <title>Welcome to my website</title>
</head>
<body>
    <h1>Jai Shri Ram!!!</h1>
    <p>This is a simple HTML page served by Nginx on an EC2 instance.</p>
</body>
</html>" | sudo tee /var/www/html/index.html

# Restart Nginx to apply changes
sudo systemctl restart nginx
