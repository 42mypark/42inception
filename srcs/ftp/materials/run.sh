#!/bin/sh
mv /materials/vsftpd.conf /etc/vsftpd/
adduser -D ${FTP_USER_NAME};
echo "${FTP_USER_NAME}:${FTP_USER_PASS}" | chpasswd;
mkdir -p /wordpress/uploaded/;
chown -R ${FTP_USER_NAME}:${FTP_USER_NAME} /wordpress/;
exec /usr/sbin/vsftpd "/etc/vsftpd/vsftpd.conf";
