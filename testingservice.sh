##Email Adress were 
sendMailTo="test@test.com"
HttpStatus=$(curl -I 127.0.0.1 2>/dev/null | head -n 1 | cut -d$' ' -f2)


testServiciupePort=$(netstat -tulpn |grep -E '80|apache2')
#echo " haha :  $testServiciupePort"
#echo "Htppstatus  este  $HttpStatus"
if pgrep -x "apache2" > /dev/null
then 
	echo "Apache2 este UP"
else 
	echo "Apache2 a fost Down acum ar trebui sa fie up"
	/etc/init.d/apache2 start
#	mail -s "Serviciul Apache2 e fost Down acum ar trebui sa reporneasca" $sendMailTo < /var/log/apache2/error.log
fi
if [ "$testServiciupePort"!="0" ];
then
	echo "Serviciul Apache2 este pe portul 80"
else 
	echo "Serviciul Apache nu este pe portul 80"
#	mail -s "Serviciul Apache2 nu este setat pe portul 80" $sendMailTo 
fi
if [ "$HttpStatus" == "200" ]
then 
	echo "Http Status $HttpStatus"
else 
	echo "Http Status error $HttpStatus"
#	mail -s "Http error status $HttpStatus" $sendMailTo < /var/log/apache2/errr.log
fi
