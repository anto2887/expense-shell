log_file=/tmp/expense.log
color="\e[31m"

echo -e "${color} Disable MySQL 8 \e[0m"
dnf module disable mysql -y
echo $?

echo -e "${color} Copy in the mysql.repo file \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo
echo $?

echo -e "${color} Install MySQL Server \e[0m"
dnf install mysql-community-server -y
echo $?

echo -e "${color} Start MySQL Service \e[0m"
systemctl enable mysqld
systemctl start mysqld
echo $?

echo -e "${color} Changing the default root database password \e[0m"
mysql_secure_installation --set-root-pass ExpenseApp@1
echo $?
