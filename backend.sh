dnf module disable nodejs -y
dnf module enable nodejs:18 -y

cp backend.service /etc/systemd/system/backend.service

dnf install nodejs -y

useradd expense

mkdir /app

curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip 
cd /app 
unzip /tmp/backend.zip

cd /app 
npm install 

dnf install mysql -y
mysql -h 172.31.21.14 -uroot -pExpenseApp@1 < /app/schema/backend.sql

systemctl daemon-reload
systemctl enable backend 
systemctl start backend
