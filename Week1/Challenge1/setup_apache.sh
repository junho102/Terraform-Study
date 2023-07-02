#!/bin/bash

sudo apt -y update

sudo apt install -y apache2

sudo systemctl enable aapache2.service
sudo systemctl start apache2.service

sleep 15

sudo tee /var/www/html/index.html <<EOF
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title> LeeJunHo </title>
</head>

<body>
<p>Hello! My name is Lee Jun Ho</p>
</body>
</html>
EOF

sudo systemctl restart apache2.service