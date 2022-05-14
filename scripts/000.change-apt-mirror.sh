#!/bin/bash
SCRIPT_DIR=$(realpath $0|xargs dirname)
source $SCRIPT_DIR/bash-libraries/lib/liblog.bash

DISTRIBUTION=$(lsb_release -is)
info "Updating apt source to sjtu mirror..."

if [[ $DISTRIBUTION = "Ubuntu" ]]; then
	sed -i.orig 's/http:\/\/.*.ubuntu.com/http:\/\/mirror.sjtu.edu.cn\/ubuntu/g' /etc/apt/sources.list
elif [[ $DISTRIBUTION = "Debian" ]]; then
	sed -i.orig "s|http://deb.debian.org/debian|http://mirror.sjtu.edu.cn/debian|g" /etc/apt/sources.list
else
	error Unknown distribution, ignoring...
	exit -1
fi

apt update
if [[ $? -ne 0 ]]; then
	error Unable to update mirror, reverting...
	mv /etc/apt/sources.list.orig /etc/apt/sources.list
	apt update
	info "Apt source left unchanged"
else
	info "Apt source changed to sjtu mirror"
fi
