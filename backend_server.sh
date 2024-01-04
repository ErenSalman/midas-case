#!/bin/bash

# Tomcat execution

#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd

sudo echo '<!DOCTYPE html>
<html>
<head>
<title>Hello World from case-app backend!</title>
</head>
<body>
<h1>Hello World from case-app backend!</h1>
</body>
</html>
' > /var/www/html/index.html