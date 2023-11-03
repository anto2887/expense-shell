log_file=/tmp/expense.log
color="\e[35m"

echo -e "${color} Disable default NodeJS version and enable NodeJS v18 \e[0m"
dnf module disable nodejs -y
dnf module enable nodejs:18 -y
echo $?

echo -e "${color} Add in the backend service \e[0m"
cp backend.service /etc/systemd/system/backend.service
echo $?

echo -e "${color} Install NodeJS v18 \e[0m"
dnf install nodejs -y
echo $?

echo -e "${color} Add Expense User \e[0m"
useradd expense
echo $?

echo -e "${color} Create the app dir \e[0m"
mkdir /app
echo $?

echo -e "${color} Download the application code to the app directory \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip 
cd /app 
unzip /tmp/backend.zip
echo $?

echo -e "${color} Create the dependencies within the app directory \e[0m"
cd /app 
npm install
echo $?

echo -e "${color} Install mysql and load the schema to the db \e[0m"
dnf install mysql -y
mysql -h 172.31.23.112 -uroot -pExpenseApp@1 < /app/schema/backend.sql
echo $?

echo -e "${color} Reload the daemon service, enable and start the backend service \e[0m"
systemctl daemon-reload
systemctl enable backend 
systemctl start backend
echo $?
