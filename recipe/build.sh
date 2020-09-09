#!/bin/bash

# set these so the default in setup.py are not used
export GRPC_PYTHON_LDFLAGS=""

export GRPC_BUILD_WITH_BORING_SSL_ASM=""
export GRPC_PYTHON_BUILD_SYSTEM_ZLIB="True"
export GRPC_PYTHON_BUILD_SYSTEM_OPENSSL="True"
export GRPC_PYTHON_BUILD_SYSTEM_CARES="True"
export GRPC_PYTHON_USE_PREBUILT_GRPC_CORE=""
export GRPC_PYTHON_BUILD_WITH_CYTHON="True"

if [[ `uname` == 'Darwin' ]]; then
    export CC=$(basename "${CC}")
    export PATH="$SRC_DIR:$PATH"
    export GRPC_PYTHON_LDFLAGS=" -framework CoreFoundation"
    cp $RECIPE_DIR/clang_wrapper.sh $SRC_DIR/$CC
    chmod +x $SRC_DIR/$CC
fi

ln -s "$CC" "$SRC_DIR/cc"
export PATH="$SRC_DIR:$PATH"

$PYTHON -m pip install . --no-deps --ignore-installed --no-cache-dir -vvv
