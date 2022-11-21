if [ -z "$1" ]; then
 echo Input argument Password is needed
 exit
fi

ROBOSHOP_MYSQL_PASSWORD=$1

STAT(){
  if [ $1 -eq 0 ]; then
    echo SUCCESS
  else
    echo FAILURE
    exit
  fi
}

PRINT() {
  echo -e "\e[33m$1\e[0m"
}

PRINT "Downloading MySQL Repo File"
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo
STAT $?

PRINT "Disable MySQL 8 Version repo"
dnf module disable mysql -y
STAT $?

PRINT "Install MySQL"
yum install mysql-community-server -y
STAT $?

PRINT "Enable MySQL service"
systemctl enable mysqld
STAT $?

PRINT "Start MySQL service"
systemctl restart mysqld
STAT $?

echo show databases | mysql -uroot -p${ROBOSHOP_MYSQL_PASSWORD}
if [ $? -ne 0 ]
then
  echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROBOSHOP_MYSQL_PASSWORD}';" > /tmp/root-pass-sql
  DEFAULT_PASSWORD=$(grep 'A temporary password' /var/log/mysqld.log | awk '{print $NF}')
  cat /tmp/root-pass-sql | mysql --connect-expired-password -uroot -p"${DEFAULT_PASSWORD}"

fi
