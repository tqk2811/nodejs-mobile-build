#!/bin/bash
if [ "$1" == "arm" ]
then
    export TARGET=armv8a-arm-none-eabi
    export ARCH_SUB=armv7a
    export TARGET_TOOLCHAIN=armv7a-linux-androideabi
    export TARGET_DIRNAME=arm-linux-androideabi
else
    #default arm64
    export TARGET=aarch64
    export ARCH_SUB=aarch64
    export TARGET_TOOLCHAIN=aarch64-linux-android
    export TARGET_DIRNAME=$TARGET_TOOLCHAIN
fi

#ndk
export NDK=$PWD/../android-ndk-r25
export API=24

#tool chain
export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64

export CC=$TOOLCHAIN/bin/$TARGET_TOOLCHAIN$API-clang
export AS=$CC
export CXX=$TOOLCHAIN/bin/$TARGET_TOOLCHAIN$API-clang++
export AR=$TOOLCHAIN/bin/llvm-ar
export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
export STRIP=$TOOLCHAIN/bin/llvm-strip

#system root
export SYSROOT=$TOOLCHAIN/sysroot/usr
export LNDK=$SYSROOT/lib/$TARGET_DIRNAME
export INDK=$SYSROOT/include
export INDKTARGET=$INDK/$TARGET_DIRNAME

#Nodejs
export NODE=$PWD/../out/$ARCH_SUB/usr/local
export LNODE=$NODE/lib
export INODE=$NODE/include/node
export PATH=$PATH:$LNODE

#Node module lib
export INODEMODULE=$PWD/node_modules/nan

#output
export OUT=$PWD/TestProj

export DEFINES="-DUSING_UV_SHARED -DUSING_V8_SHARED -D__linux__"
export INCLUDE="-I$INODEMODULE -I$INODE -I$INDK -I$INDKTARGET -I$INDK/c++/v1"

rm -f *.o
rm -f *.node

$CXX -target $TARGET -std=c++14 -fPIC $INCLUDE $DEFINES -c test-addon.cpp
$CXX -shared -o $OUT/test-addon.node test-addon.o $LNODE/libnode.so

# ARFLAGS - for ar achiver
# ASFLAGS - for as assembler
# CXXFLAGS - for c++ compiler
# COFLAGS - for co utility
# CPPFLAGS - for C preprocessor
# FFLAGS - for Fortran compiler
# LFLAGS - for lex
# PFLAGS - for Pascal compiler
# YFLAGS - for yacc