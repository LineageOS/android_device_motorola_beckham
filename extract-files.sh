#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

function blob_fixup() {
    case "${1}" in
        # Correct mods gid
        system/etc/permissions/com.motorola.mod.xml)
            sed -i "s|mot_mod|oem_5020|g" "${2}"
            ;;
        # memset shim
        vendor/bin/charge_only_mode)
            for LIBMEMSET_SHIM in "$(grep -L libmemset_shim.so ${2})"; do
                "${PATCHELF}" --add-needed "libmemset_shim.so" "$LIBMEMSET_SHIM"
            done
            ;;
        # Add uhid group for fingerprint service
        vendor/etc/init/android.hardware.biometrics.fingerprint@2.1-service.rc)
            sed -i "s/input/uhid input/" "${2}"
            ;;
        # Replace libcutils with libprocessgroup
        vendor/lib/hw/audio.primary.sdm660.so)
            "${PATCHELF}" --replace-needed "libcutils.so" "libprocessgroup.so" "${2}"
            ;;
        # Fix camera recording
        vendor/lib/libmmcamera2_pproc_modules.so)
            sed -i "s/ro.product.manufacturer/ro.product.nopefacturer/" "${2}"
            ;;
        # Load ZAF configs from vendor
        vendor/lib/libzaf_core.so)
            sed -i "s|/system/etc/zaf|/vendor/etc/zaf|g" "${2}"
            ;;
    esac
}

# If we're being sourced by the common script that we called,
# stop right here. No need to go down the rabbit hole.
if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
    return
fi

set -e

export DEVICE=beckham
export DEVICE_COMMON=sdm660-common
export VENDOR=motorola

"./../../${VENDOR}/${DEVICE_COMMON}/extract-files.sh" "$@"
