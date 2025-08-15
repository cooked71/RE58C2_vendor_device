#!/bin/bash

MODULES_DIR="proprietary/vendor_dlkm/lib/modules"
OUTPUT_FILE="vendor_dlkm_modules_android_bp_generated.bp"

echo "// Auto-generated prebuilt_etc modules for vendor DLKM kernel modules" > "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

for ko in "$MODULES_DIR"/*.ko; do
    filename=$(basename "$ko")
    modulename="vendor_dlkm_${filename//./_}"  # replace dots with underscores

    cat >> "$OUTPUT_FILE" <<EOF
prebuilt_etc {
    name: "$modulename",
    src: "$ko",
    sub_dir: "lib/modules",
    vendor: true,
    owner: "realme",
}

EOF
done

echo "Generated $(ls -1 $MODULES_DIR/*.ko | wc -l) prebuilt_etc modules in $OUTPUT_FILE"
