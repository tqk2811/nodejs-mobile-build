adb shell rm -r -f /data/local/tmp/TestProj
adb push TestProj /data/local/tmp/TestProj
adb shell chmod 755 /data/local/tmp/TestProj/test-addon.node

adb shell LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/data/local/tmp/nodejs:/system/lib:/data/local/tmp/TestProj /data/local/tmp/nodejs/node /data/local/tmp/TestProj
pause