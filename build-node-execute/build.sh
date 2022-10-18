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

#output
export OUT=$PWD/out/$ARCH_SUB

export DEFINES="-DUSING_UV_SHARED -DUSING_V8_SHARED -D__linux__"
export INCLUDE="-I$INODE -I$INDK -I$INDKTARGET -I$INDK/c++/v1"


rm -f -r $OUT
mkdir $PWD/out
mkdir $OUT
rm -f *.o

$CXX -target $TARGET -std=c++14 -fPIC $INCLUDE $DEFINES -c main.cpp
$CXX -o $OUT/node main.o $LNODE/libnode.so

cp $LNODE/libnode.so $OUT/libnode.so
cp $LNDK/libc++_shared.so $OUT/libc++_shared.so
cp $LNDK/$API/liblog.so $OUT/liblog.so
if [ "$TARGET" == "aarch64" ]
then
    echo $TARGET
    $PWD/../termux-elf-cleaner/out/termux-elf-cleaner $OUT/libc++_shared.so
fi