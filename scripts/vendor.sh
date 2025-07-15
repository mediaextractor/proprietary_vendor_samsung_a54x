tar xvf ${AP_TAR} super.img.lz4
lz4 -d super.img.lz4 super.img
rm -f super.img.lz4
simg2img super.img super_raw.img
rm -f super.img
mv -f super_raw.img super.img
./tools/lpunpack -p vendor super.img .
rm -f super.img
[[ -e vendor.img ]] && zip ${LATEST_SHORTVERSION}_vendor.zip vendor.img
