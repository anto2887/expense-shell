log_file=/tmp/expense.log
color="\e[34m"

status_check (){
  if [ $? -eq 0]; then
    echo -e "\e[32m SUCCESS \e[0m"
  else
    echo "\e[31m FAILURE \e[0m"
  fi
}

if [ -z "$1" ]; then
  ech
  exit
fi

MYSQL_ROOT_PASSWORD=$1