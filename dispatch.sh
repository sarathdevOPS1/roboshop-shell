source common.sh
app_name=dispatch

echo -e "$color copy dispatch service file $no_color"
cp dispatch.service /etc/systemd/system/dispatch.service &>>$log_file
echo $?

echo -e "$color install Golang $no_color"
dnf install golang -y &>>$log_file
echo $?

app_prerequisites

echo -e "$color download apllication dependencies $no_color"
go mod init dispatch
go get &>>$log_file
go build &>>$log_file
echo $?

echo -e "$color start application service  $no_color"
systemctl daemon-reload &>>$log_file
systemctl enable dispatch &>>$log_file
systemctl start dispatch &>>$log_file
echo $?