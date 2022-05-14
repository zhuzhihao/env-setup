#!/bin/bash

if [[ -z $(which unzip) ]]; then
	echo "Cannot find unzip tool, try installing with package management tool first"
	exit -1
fi

WORK_DIR=$(mktemp -d )
# download package to tmp dir
wget https://github.com/zhuzhihao/env-setup/releases/download/v0.0.1/release.zip -O $WORK_DIR/env-setup.zip

pushd $WORK_DIR
unzip env-setup.zip
source scripts/bash-libraries/lib/liblog.bash
SCRIPTS=$(find scripts/ -type f -name "*.sh"|sort -V)
for scr in $SCRIPTS; do
	info "============================"
	info "Executing $scr ..."
	info "============================"
	/bin/bash $scr
done


popd
popd
[[ $WORK_DIR =~ /tmp/.* ]] && rm -rfv $WORK_DIR
