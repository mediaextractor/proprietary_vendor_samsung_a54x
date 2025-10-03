FILES="boot.img.lz4 dtbo.img.lz4 vendor_boot.img.lz4"

tar xvf ${AP_TAR} ${FILES}
tar cvf ${LATEST_SHORTVERSION}_kernel.tar ${FILES}
rm -f $FILES
