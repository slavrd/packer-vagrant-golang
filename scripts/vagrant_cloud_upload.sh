#!/usr/bin/env bash
# Simply a wrapper for "vagrant cloud publish command"
# uploads a virtualbox box package to vagrant cloud and releases it.

#usage <vc_box_name> <vc_box_ver> <local_box_path>

# check prerequsites - passed parameters and vagrant installation
if [ "$#" != 3 ]; then
    echo "usage: $0 <vc_box_name> <vc_box_ver> <local_box_path>"
    exit 1
fi

which vagrant > /dev/null || {
    echo "vagrant is not installed. Visit www.vagrantup.com and install it."
    exit 1
}

BOX="$1"
BOX_VER="$2"
BOX_PATH="$3"

vagrant cloud publish \
    --description "An Ubuntu Xenial64 box with golang and some basic tools installed" \
    --force --release \
    "$BOX" "$BOX_VER" virtualbox "$BOX_PATH"
