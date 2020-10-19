FROM asclinux/linuxforphp-8.2-ultimate:7.4-nts
MAINTAINER doug.bierer@etista.com
RUN \
	echo "Clone from repo ..." && \
	rm -rf /srv/tempo/test && \
    git clone https://github.com/dbierer/lfphp_mail_test.git /srv/tempo/test
RUN \
	echo "Setting up Apache ..." && \
	mv -fv /srv/www /srv/www.OLD && \
	ln -sfv /srv/tempo/test /srv/www && \
	echo "ServerName lfphp_mail_test" >> /etc/httpd/httpd.conf && \
	chown apache:apache /srv/www && \
	chown -R apache:apache /srv/tempo/test && \
	chmod -R 775 /srv/tempo/test
CMD lfphp --phpfpm --apache
