log_file=/tmp/expense.log
color="\e[35m"

echo -e "${color} Disable default NodeJS version and enable NodeJS v18 \e[0m"
dnf module disable nodejs -y &>>$log_file
dnf module enable nodejs:18 -y &>>$log_file
echo $?

echo -e "${color} Add in the backend service \e[0m"
cp backend.service /etc/systemd/system/backend.service &>>$log_file
echo $?

echo -e "${color} Install NodeJS v18 \e[0m"
dnf install nodejs -y &>>$log_file
echo $?

echo -e "${color} Add Expense User \e[0m"
useradd expense &>>$log_file
echo $?

echo -e "${color} Create the app dir \e[0m"
mkdir /app &>>$log_file
echo $?

echo -e "${color} Download the application code to the app directory \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$log_file
cd /app &>>$log_file
unzip /tmp/backend.zip &>>$log_file
echo $?

echo -e "${color} Create the dependencies within the app directory \e[0m"
cd /app &>>$log_file
npm install &>>$log_file
echo $?

echo -e "${color} Install mysql and load the schema to the db \e[0m"
dnf install mysql -y &>>$log_file
mysql -h 172.31.23.112 -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file
echo $?

echo -e "${color} Reload the daemon service, enable and start the backend service \e[0m"
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl start backend &>>$log_file
echo $?
