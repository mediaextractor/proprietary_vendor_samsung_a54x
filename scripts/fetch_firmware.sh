TABLET="SM-P620 SM-P625"
ARGS="-i ${IMEI}"
if echo "$TABLET" | grep -w ${MODEL}; then
    ARGS="-s ${SERIAL}"
fi

# Prepare samloader
python3 -m venv py_env
source "py_env/bin/activate"
pip3 install git+https://github.com/ananjaser1211/samloader.git
mkdir -p "${MODEL}_${CSC}"

# Get firmware
samloader -m ${MODEL} -r ${CSC} ${ARGS} download -O "${MODEL}_${CSC}" || exit 1
cd "${MODEL}_${CSC}"
unzip *".zip" 

# Cleanup
rm -rf *".zip"
cd ".."
deactivate
rm -rf "py_env"
