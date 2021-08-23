#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

function write_motcam_androidmk() {
    # Move MotCamera2 back to Android.mk to prevent JNI build-system from
    # messing with pre-packed JNI dependencies
    cat << EOF >> "$ANDROIDMK"
include \$(CLEAR_VARS)
LOCAL_MODULE := MotCamera2
LOCAL_MODULE_OWNER := motorola
LOCAL_SRC_FILES := proprietary/system/priv-app/MotCamera2/MotCamera2.apk
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := APPS
LOCAL_DEX_PREOPT := false
LOCAL_MODULE_SUFFIX := .apk
LOCAL_OVERRIDES_PACKAGES := Camera2
LOCAL_PRIVILEGED_MODULE := true
LOCAL_REPLACE_PREBUILT_APK_INSTALLED := \$(LOCAL_PATH)/\$(LOCAL_SRC_FILES)
include \$(BUILD_PREBUILT)

EOF

    sed -i '/MotCamera2/,+10d' "${ANDROID_ROOT}/vendor/${VENDOR}/${DEVICE}/Android.bp"
}

set -e

export -f write_motcam_androidmk
export USES_MOTCAMERA=true

export DEVICE=beckham
export DEVICE_COMMON=sdm660-common
export VENDOR=motorola

"./../../${VENDOR}/${DEVICE_COMMON}/setup-makefiles.sh" "$@"
