#!/bin/bash
# Install Nginx
sudo su
yum install nginx -y
systemctl start nginx
systemctl enable nginx
cat <<'EOF' > /usr/share/nginx/html/index.html
<html>
<head>
 <title>Custom AMI Demo</title>
 <style>
   body {
     background-color: #F4F4F4;
     font-family: Arial, sans-serif;
     display: flex;
     justify-content: center;
     align-items: center;
     height: 100vh;
     margin: 0;
   }
   .container {
     text-align: center;
     padding: 20px;
     border-radius: 8px;
     background: #fff;
     box-shadow: 0 4px 8px rgba(0,0,0,0.1);
   }
   h1 {
     color: #333;
   }
   p {
     color: #666;
   }
   a {
     display: inline-block;
     margin-top: 20px;
     padding: 10px 20px;
     background-color: #007BFF;
     color: white;
     text-decoration: none;
     border-radius: 5px;
   }
   a:hover {
     background-color: #0056B3;
   }
 </style>
</head>
<body>
 <div class="container">
   <h1>Welcome to Your Nginx Server!</h1>
   <p>This page is served from a custom AMI with Nginx running.</p>
   <a href="https://www.example.com">Learn More</a>
 </div>
</body>
</html>
EOF
