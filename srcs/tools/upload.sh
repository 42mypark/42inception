#!/bin/sh
ENVFILE=/home/mypark/42inception/srcs/ftp/.ftp.env
export $(cat ${ENVFILE} | xargs);
FTP_SERVER=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' inception_ftp);
ftp -n -v  $FTP_SERVER << EOF
user $FTP_USER_NAME $FTP_USER_PASS
prompt
mput $@
EOF