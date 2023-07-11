#!/bin/bash
echo "Hello, ${my_name}" > index.html
nohup busybox httpd -f -p ${port_num} &