#COMPONENT=dispatch
#source common.sh

#PRINT "Install GoLang"
#yum install golang -y &>>$LOG
#STAT $?


#useradd roboshop
#curl -L -s -o /tmp/dispatch.zip https://github.com/roboshop-devops-project/dispatch/archive/refs/heads/main.zip
#unzip /tmp/dispatch.zip
#mv dispatch-main dispatch
#cd dispatch
#go mod init dispatch
#o get
#go build

#mv /home/roboshop/dispatch/systemd.service /etc/systemd/system/dispatch.service
#systemctl daemon-reload

#systemctl enable dispatch
#systemctl start dispatch