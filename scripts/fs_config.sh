print_entry_fs() {
    local path="$1"
    local gid="$2"
    local mode="$3"
    echo "$path 0 $gid $mode capabilities=0x0"
}

generate_entries() {
    local base="$1"
    local gid_dir="2000"
    local gid_file="0"
    print_entry_fs "$base" "$gid_dir" "755"
    find "$base" -printf '%P\n' | sort | while read -r relpath; do
        [ -z "$relpath" ] && continue
        fullpath="$base/$relpath"
        outpath="${fullpath#./}"
        if [ -d "$fullpath" ]; then
            print_entry_fs "$outpath" "$gid_dir" "755"
        elif [ -f "$fullpath" ]; then
            print_entry_fs "$outpath" "$gid_file" "644"
        fi
    done
}

[ -f "fs_config/fs.${MODEL}_${OMC}" ] && rm -f "fs_config/fs.${MODEL}_${OMC}"

{
    generate_entries "vendor/firmware"
    echo "vendor/firmware/NPU.bin 0 0 644 capabilities=0x0"
    echo "vendor/firmware/os.checked.bin 0 0 644 capabilities=0x0"
    generate_entries "vendor/tee"
} >> "fs_config/fs.${MODEL}_${OMC}"

mkdir -p "vendor/firmware/${MODEL}"
for b in "${audio_blobs[@]}"; do
    mv "vendor/firmware/$b" "vendor/firmware/${MODEL}/$b"
done

mkdir -p vendor/tee/${MODEL}
cp -rfa vendor/tee_old/* vendor/tee/${MODEL}

{
    echo ""
    echo "Custom Path"
    generate_entries "vendor/firmware/${MODEL}"
    echo "vendor/firmware/${MODEL}/NPU.bin 0 0 644 capabilities=0x0"
    echo "vendor/firmware/${MODEL}/os.checked.bin 0 0 644 capabilities=0x0"
    generate_entries "vendor/tee/${MODEL}"
} >> "fs_config/fs.${MODEL}_${OMC}"
