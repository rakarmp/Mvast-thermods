#!/system/bin/sh

while [[ -z $(getprop sys.boot_completed) ]]; do sleep 5; done

sh /data/adb/modules/mvast-thermods/core/MTMODS.sh