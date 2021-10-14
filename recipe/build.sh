#!/bin/bash

# set these so the default in setup.py are not used
# it seems that we need to link to pthrad on linux or osx.
export GRPC_PYTHON_LDFLAGS="-lpthread"

export GRPC_BUILD_WITH_BORING_SSL_ASM=""
export GRPC_PYTHON_BUILD_SYSTEM_ZLIB="True"
export GRPC_PYTHON_BUILD_SYSTEM_OPENSSL="True"
export GRPC_PYTHON_BUILD_SYSTEM_CARES="True"
export GRPC_PYTHON_USE_PREBUILT_GRPC_CORE=""
export GRPC_PYTHON_BUILD_WITH_CYTHON="True"

if [[ "$target_platform" == osx-* ]]; then
    export CC=$(basename "${CC}")
    export PATH="$SRC_DIR:$PATH"
    export GRPC_PYTHON_LDFLAGS=" -framework CoreFoundation"
    cp $RECIPE_DIR/clang_wrapper.sh $SRC_DIR/$CC
    chmod +x $SRC_DIR/$CC
fi

if [[ "$target_platform" == osx-64 ]]; then
    export CFLAGS="$CFLAGS -DTARGET_OS_OSX=1"
fi

ln -s "$(which $CC)" "$SRC_DIR/cc"
export PATH="$SRC_DIR:$PATH"

$PYTHON -m pip install . --no-deps --ignore-installed --no-cache-dir -vvv
