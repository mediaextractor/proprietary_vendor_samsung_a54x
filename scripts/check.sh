VS=$(echo ${AP_TAR} | cut -d'_' -f3)
VC=$(echo ${CSC_TAR} | cut -d'_' -f4)
ANDROID=$(curl -s --retry 5 --retry-delay 5 "https://fota-cloud-dn.ospserver.net/firmware/${CSC}/${MODEL}/version.xml" | grep latest | sed -E 's/.*o="([0-9]+)".*/\1/')
[[ $VS == "${LATEST_SHORTVERSION}" ]]
[[ $VC == "${LATEST_CSCVERSION}" ]]
echo "Android Version: $ANDROID" >> "versions.txt"
echo "PDA version: $VS" >> "versions.txt"
echo "CSC version: $VC" >> "versions.txt"
