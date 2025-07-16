FILES=( "boot.img.lz4" "dtbo.img.lz4" "vbmeta.img.lz4" "vendor_boot.img.lz4" )

for f in "${FILES[@]}"; do
    tar xvf ${AP_TAR} ${f}
    lz4 -d ${f}
done

tar cvf ${LATEST_SHORTVERSION}_kernel.tar *.img
rm *.img