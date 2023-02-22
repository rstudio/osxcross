#!/bin/bash

set -x
set -e

export UNATTENDED=1
export GCC_VERSION=13.0.1
export SDK_VERSION=13.0
export TARGET_DIR=
export ENABLE_FORTRAN=1
export PATH=$PATH:/workspaces/osxcross/target/bin
export OCDEBUG=1

rm -rf build
./build.sh
./build_gcc.sh | tee > gcc.log 2>&1
