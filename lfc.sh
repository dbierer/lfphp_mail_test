#!/bin/bash
DIR=`pwd`
TOOLS_DIR=$DIR/vendor/phpcl/lfc_tools
LFC_DIR=$DIR/vendor/linuxforphp/linuxforcomposer/bin
LFC_PID=$DIR/vendor/composer
export USAGE="Usage: lfc.sh start|stop|deploy|init|shell|swap|creds"
if [[ -f "$LFC_PID/linuxforcomposer.pid" ]]; then
	export CONTAINER=`cat $LFC_PID/linuxforcomposer.pid`
else
	export CONTAINER="lfphpcloud_net"
fi
if [[ -z "$1" ]]; then
	echo $USAGE
	exit 1
fi
if [[ "$1" = "start" || "$1" = "stop" || "$1" = "deploy" ]]; then
	php $LFC_DIR/linuxforcomposer.phar docker:run $1
elif [[ "$1" = "creds" ]]; then
	php $TOOLS_DIR/generate_creds.php $2 $3 $4 $5 $6
elif [[ "$1" = "init" ]]; then
	if [[ -z ${CONTAINER} ]]; then
		echo "Unable to locate running container"
	else
		docker exec $CONTAINER /bin/bash -c "/etc/init.d/php-fpm start"
		docker exec $CONTAINER /bin/bash -c "/etc/init.d/httpd start"
	fi
elif [[ "$1" = "shell" ]]; then
	if [[ -z ${CONTAINER} ]]; then
		echo "Unable to locate running container"
	else
		docker exec -it $CONTAINER /bin/bash
	fi
elif [[ "$1" = "swap" ]]; then
	if [[ -z ${CONTAINER} ]]; then
		echo "Unable to locate running container"
	else
		docker exec $CONTAINER /bin/bash -c "rm /srv/www"
		docker exec $CONTAINER /bin/bash -c "ln -s /srv/repo/public /srv/www"
	fi
else
	echo $USAGE
	exit 1
fi
