source common.sh

echo -e "${color} Install Nginx \e[0m"
dnf install nginx -y &>>$log_file
if [ $? -eq 0]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo "\e[31m FAILURE \e[0m"
fi

echo -e "${color} Copy in the expense.conf file \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
if [ $? -eq 0]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo "\e[31m FAILURE \e[0m"
fi

echo -e "${color} Remove the default content that web server is serving \e[0m"
rm -rf /usr/share/nginx/html/* &>>$log_file
if [ $? -eq 0]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo "\e[31m FAILURE \e[0m"
fi

echo -e "${color} Download the frontend content \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>$log_file
if [ $? -eq 0]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo "\e[31m FAILURE \e[0m"
fi

echo -e "${color} Download the frontend content \e[0m"
cd /usr/share/nginx/html &>>$log_file
unzip /tmp/frontend.zip &>>$log_file
if [ $? -eq 0]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo "\e[31m FAILURE \e[0m"
fi

echo -e "${color} Start & Enable Nginx service \e[0m"
systemctl enable nginx &>>$log_file
systemctl start nginx &>>$log_file
if [ $? -eq 0]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo "\e[31m FAILURE \e[0m"
fi