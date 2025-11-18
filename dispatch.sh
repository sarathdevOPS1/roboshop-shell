source common.sh

echo -e "$color copy dispatch service file $no_color"
cp dispatch.service /etc/systemd/system/dispatch.service

echo -e "$color install Golang $no_color"
dnf install golang -y

echo -e "$color add application user $no_color"
useradd roboshop

echo -e "$color create application directory $no_color"
rm -rf /app
mkdir /app

echo -e "$color downlaod apllication content $no_color"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch-v3.zip
cd /app

echo -e "$color extract application content $no_color"
unzip /tmp/dispatch.zip

echo -e "$color download apllication dependencies $no_color"
go mod init dispatch
go get
go build

echo -e "$color start application service  $no_color"
systemctl daemon-reload
systemctl enable dispatch
systemctl start dispatch