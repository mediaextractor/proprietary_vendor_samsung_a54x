FILES=( "boot.img" "dtbo.img" "vbmeta.img" "vendor_boot.img" )

for f in "${FILES[@]}"; do
    tar xvf ${AP_TAR} ${f}
    lz4 -d ${f}.lz4 >/dev/null 2>&1
done

tar cvf ${LATEST_SHORTVERSION}_kernel.tar *.img
rm *.img