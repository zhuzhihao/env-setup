#!/bin/bash

WORK_DIR=$(mktemp -d )
# download package to tmp dir
cp -r ./* $WORK_DIR/

pushd $WORK_DIR
source scripts/bash-libraries/lib/liblog.bash
SCRIPTS=$(find scripts/ -type f -name "*.sh"|sort -V)
for scr in $SCRIPTS; do
	info "============================"
	info "Executing $scr ..."
	info "============================"
	/bin/bash $scr
done



popd
[[ $WORK_DIR =~ /tmp/.* ]] && rm -rfv $WORK_DIR
