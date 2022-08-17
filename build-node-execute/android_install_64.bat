cd out/aarch64
adb shell rm -r -f /data/local/tmp/nodejs
adb push libc++_shared.so /data/local/tmp/nodejs/libc++_shared.so
adb push libnode.so /data/local/tmp/nodejs/libnode.so
@REM adb push liblog.so /data/local/tmp/nodejs/liblog.so
adb push node /data/local/tmp/nodejs/node
adb shell chmod 755 /data/local/tmp/nodejs/node

cd ../../
adb shell rm -r -f /data/local/tmp/TestProj
adb push TestProj /data/local/tmp/TestProj

adb shell LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/data/local/tmp/nodejs:/system/lib64 /data/local/tmp/nodejs/node /data/local/tmp/TestProj
pause