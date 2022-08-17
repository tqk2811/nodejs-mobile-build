#ndk
export NDK=/mnt/d/IT/Gitlab/Qualphey/nodejs-mobile-build/android-ndk-r25
export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64
export PATH=$PATH:$TOOLCHAIN/bin
export TARGET=aarch64-linux-android
export API=24
export CC=$TOOLCHAIN/bin/$TARGET$API-clang
export AS=$CC
export CXX=$TOOLCHAIN/bin/$TARGET$API-clang++
export AR=$TOOLCHAIN/bin/llvm-ar
export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
export STRIP=$TOOLCHAIN/bin/llvm-strip
export SYSROOT=$TOOLCHAIN/sysroot

#Nodejs
export NODE=../out/aarch64/usr/local
export LNODE=$NODE/lib
export INODE=$NODE/include/node
export PATH=$PATH:$LNODE

#output
export OUT=out/aarch64
# CFLAGS_BASE_LIST="-c -D_7ZIP_AFFINITY_DISABLE=1 -pipe -fPIE -fexceptions -frtti \
#         -mcpu=cortex-a53+crc+crypto -Wno-suggest-override -Wno-suggest-destructor-override \
#         -ffunction-sections -fdata-sections -Wl,--gc-sections" \

export CFLAGS= -fvisibility=default -fPIE
export LDFLAGS= -rdynamic -fPIE -pie

make CC=$CC CXX=$CXX -f Makefile all