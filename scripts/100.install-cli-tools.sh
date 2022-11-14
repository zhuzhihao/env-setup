#!/bin/bash
SCRIPT_DIR=$(realpath $0|xargs dirname)
source $SCRIPT_DIR/bash-libraries/lib/liblog.bash

trap "error 'Some error occurred...'; exit -1" ERR

case $(uname -m) in

	aarch64)
		ARCH=arm64
		;;
	armv7l)
		ARCH=armhf
		;;
	x86_64)
		ARCH=amd64
		;;
esac

# assume run as root, and source updated already
apt install -y fzf exa htop bmon traceroute iotop bash-completion
if [[ -n $(apt search --names-only '^bat$' 2>/dev/null |grep bat) ]]; then
        apt install -y bat
fi
