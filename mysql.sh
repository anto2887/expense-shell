source common.sh

if [ -z "$1" ]; then
  ech
  exit
fi

MYSQL_ROOT_PASSWORD=$1

echo -e "${color} Disable MySQL 8 \e[0m"
dnf module disable mysql -y &>>$log_file
if [ $? -eq 0]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo "\e[31m FAILURE \e[0m"
fi

echo -e "${color} Copy in the mysql.repo file \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
if [ $? -eq 0]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo "\e[31m FAILURE \e[0m"
fi

echo -e "${color} Install MySQL Server \e[0m"
dnf install mysql-community-server -y &>>$log_file
if [ $? -eq 0]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo "\e[31m FAILURE \e[0m"
fi

echo -e "${color} Start MySQL Service \e[0m"
systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file
if [ $? -eq 0]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo "\e[31m FAILURE \e[0m"
fi

echo -e "${color} Changing the default root database password \e[0m"
mysql_secure_installation --set-root-pass ${MYSQL_ROOT_PASSWORD} &>>$log_file
if [ $? -eq 0]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo "\e[31m FAILURE \e[0m"
fi
