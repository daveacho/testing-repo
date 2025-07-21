locals {
  app_user_data = <<-EOF
  #!/bin/bash
  sudo apt update
  sudo hostnamectl set-hostname python-server
  sudo apt install python3-pip unzip -y
  sudo apt install postgresql postgresql-contrib -y
  sudo systemctl start postgresql.service
  sudo apt install python3.8-venv
  curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
  sudo apt-get install nodejs -y
  sudo apt install npm  -y
  sudo apt install -y awslogs  # Ubuntu/Debian
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
  mkdir /home/ubuntu/react-django-project
  sudo chown -R ubuntu:ubuntu /home/ubuntu/react-django-project
  sudo su -c "git clone https://github.com/daveacho/myNotes.git" ubuntu
  sudo apt install -y wget curl expect

  # Install pgAdmin 4
  curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg
  echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" | sudo tee /etc/apt/sources.list.d/pgadmin4.list
  sudo apt update -y
  sudo apt install -y pgadmin4

  # Automate the pgAdmin 4 web setup
  expect <<EOT
  spawn sudo /usr/pgadmin4/bin/setup-web.sh
  expect "Email address:" 
  send "john@example.com\r"
  expect "Password:"
  send "Password123\r"
  expect "Retype password:"
  send "Password123\r"
  expect eof
  EOT

  # Restart Apache to apply changes (if using Apache as the web server)
  sudo systemctl restart apache2

  

  EOF
}

#wget https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip
#unzip aws-sam-cli-linux-x86_64.zip -d sam-installation
# aws cloudformation delete-stack --stack-name influxdb
# aws cloudformation wait stack-delete-complete --stack-name influxdb

#To open pgadmin in the browser type: <ip-address-of-ec2-instance>/pgadmin4
#npm run build
#npm run dev -- --host 0.0.0.0
#python3 manage.py runserver 0.0.0.0:8000
#python3 manage.py dumpdata > data.json
#testing redis
# from django.core.cache import cache
# cache.set("test_key", "Hello Redis!", timeout=30)
# print(cache.get("test_key"))  # Should return "Hello Redis!"
#migrating data from sqlite3 to postgresql
#python3 manage.py dumpdata --natural-primary --natural-foreign --indent 4 > data.json
# DATABASES = {
#     'default': {
#         'ENGINE': 'django.db.backends.postgresql',
#         'NAME': os.getenv('DB_NAME')
#         'USER': os.getenv('DB_USER')
#         'PASSWORD': os.getenv('DB_PASS')
#         'HOST': os.getenv('DB_HOST')
#         'PORT': os.getenv('DB_PORT')
#     }
# }
# python manage.py makemigrations
# python manage.py migrate
# python manage.py loaddata data.json
#rm db.sqlite3
#sudo /usr/pgadmin4/bin/setup-web.sh
# django
# djangorestframework
# django-cors-headers
# djangorestframework-simplejwt
# djoser
# drf-yasg
# django-prometheus
# psycopg2-binary
# django-redis
# boto3
# django-storages
# opentelemetry-api
# opentelemetry-sdk
# opentelemetry-instrumentation-django
# opentelemetry-exporter-influxdb

#ALTER USER postgres WITH PASSWORD 'new-secure-password';
