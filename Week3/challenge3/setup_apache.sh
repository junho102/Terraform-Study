#!/bin/bash

sudo yum update -y

sudo yum install -y httpd

sudo systemctl enable httpd
sudo systemctl start httpd

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

sudo systemctl start httpd