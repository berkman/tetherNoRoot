cd "~/Dropbox/Android/Nexus 6/tethering/"

adb reboot-bootloader
sleep 5

fastboot boot twrp-2.8.7.1-shamu.img
sleep 5

read -p "Enter the device encryption password on your phone (if set)"
sleep 5

adb shell mount -t ext4 /dev/block/bootdevice/mmcblk0p41 /system

adb pull /system/build.prop

if grep "net.tethering.noprovisioning" build.prop
then
    sed -i '.orig' 's/.*net.tethering.noprovisioning.*/net.tethering.noprovisioning=true/' build.prop
else
    cp build.prop build.prop.orig
    echo "net.tethering.noprovisioning=true" >> build.prop
fi

#adb push build.prop /system/build.prop

adb reboot
