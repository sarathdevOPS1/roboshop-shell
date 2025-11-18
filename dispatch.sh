echo -e "\e[35m copy dispatch service file \e[0m"
cp dispatch.service /etc/systemd/system/dispatch.service

echo -e "\e[35m install Golang \e[0m"
dnf install golang -y

echo -e "\e[35m add application user \e[0m"
useradd roboshop

echo -e "\e[35m create application directory \e[0m"
mkdir /app

echo -e "\e[35m downlaod apllication content \e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch-v3.zip
cd /app

echo -e "\e[35m extract application content \e[0m"
unzip /tmp/dispatch.zip

echo -e "\e[35m download apllication dependencies \e[0m"
go mod init dispatch
go get
go build

echo -e "\e[35m start application service  \e[0m"
systemctl daemon-reload
systemctl enable dispatch
systemctl start dispatch