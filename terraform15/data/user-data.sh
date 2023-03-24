#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install -y nginx1 
sudo service nginx enable
sudo service nginx start
sudo rm /usr/share/nginx/html/index.html
echo '<html><head><title>Bootcamp Terraform Server</title></head><body><h1>Welcome to &#128640; Bootcamp</h1></body></html>' | sudo tee /usr/share/nginx/html/index.html