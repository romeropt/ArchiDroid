#!/sbin/sh

good_ffc_device() {
  if [ -f /sdcard/.forcefaceunlock ]; then
    return 0
  fi
  if cat /proc/cpuinfo |grep -q Victory; then
    return 1
  fi
  if cat /proc/cpuinfo |grep -q herring; then
    return 1
  fi
  if cat /proc/cpuinfo |grep -q sun4i; then
    return 1
  fi
  return 0
}

if good_ffc_device && [ -e /system/etc/permissions/android.hardware.camera.front.xml ]; then
  echo "Installing face detection support"
  cp -a /tmp/face/* /system/
  chmod 755 /system/addon.d/71-gapps-faceunlock.sh
elif  [ -d /system/vendor/pittpatt/ ]; then
  rm -rf /system/vendor/pittpatt/
  rm  -f /system/app/FaceLock.apk
  rm  -f /system/lib/libfacelock_jni.so
  rm  -f /system/addon.d/71-gapps-faceunlock.sh
fi
rm -rf /tmp/face

#if ( ! grep -q "neon" /proc/cpuinfo ); then
#  echo "Installing support for non-NEON target"
#  cp -a /tmp/noneon/* /system/
#fi
#rm -rf /tmp/noneon

