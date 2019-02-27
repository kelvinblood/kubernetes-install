lines=`curl -o /dev/null -s -w %{http_code} http://0.0.0.0:8081/admin`
if [ "000" = "$lines" ];then
	exit -1
else
	exit 0
fi
