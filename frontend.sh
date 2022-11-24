COMPONENT=frontend
CONTENT="*"
source common.sh

PRINT "Install Nginx"
yum install nginx -y &>>$LOG
STAT $?

APP_LOC=/usr/share/nginx/html

DOWNLOAD_APP_CODE

mv frontend-main/static/* .

PRINT "Copy Roboshop Configuration File"
mv frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf
STAT $?

PRINT "Update Roboshop Configuration"
sed -i -e '/catalogue/ s/localhost/dev-catalogue.devops-d.online/'  -e '/user/ s/localhost/dev-user.devops-d.online/' -e '/cart/ s/localhost/dev-cart.devops-d.online/' -e '/shipping/ s/localhost/dev-shipping.devops-d.online/' -e '/payment/ s/localhost/dev-payment.devops-d.online/' /etc/nginx/default.d/roboshop.conf
STAT $?

PRINT "Enable Nginx Service"
systemctl enable nginx &>>$LOG
STAT $?

PRINT "Restart Nginx Service"
systemctl restart nginx &>>$LOG
STAT $?
