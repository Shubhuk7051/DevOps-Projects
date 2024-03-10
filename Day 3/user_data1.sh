#!/bin/bash

apt update
apt install -y apache2

# Get the instance ID using the instance metadata
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

# Install the AWS CLI
apt install -y awscli

# Create a simple HTML file with the LinkedIn connections
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
  <title>My GitHub</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f4f4f4;
    }
    .container {
      max-width: 800px;
      margin: 20px auto;
      padding: 20px;
      background-color: #fff;
      border-radius: 5px;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }
    h1 {
      color: #333;
    }
    p {
      color: #666;
    }
    .github-link {
      display: inline-block;
      margin-top: 10px;
      padding: 10px 20px;
      background-color: #0077b5;
      color: #fff;
      text-decoration: none;
      border-radius: 5px;
    }
    .github-link:hover {
      background-color: #005f8b;
    }
  </style>
</head>
<body>
  <div class="container">
    <h1>My GitHub</h1>
    <p>Welcome to my GitHub!</p>
    <p>Click the button below to view my Github profile:</p>
    <a class="github-link" href="https://www.github.com/Shubhuk7051">View My Github Profile</a>
  </div>
</body>
</html>
EOF

# Start Apache and enable it on boot
systemctl start apache2
systemctl enable apache2
