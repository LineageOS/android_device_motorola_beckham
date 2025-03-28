#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

import extract_utils.tools

extract_utils.tools.DEFAULT_PATCHELF_VERSION = '0_9'

from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)

from extract_utils.fixups_lib import (
    lib_fixup_vendorcompat,
    lib_fixups_user_type,
    libs_proto_3_9_1,
)

from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    'device/motorola/beckham',
    'device/motorola/msm8998-common',
    "hardware/qcom-caf/msm8998",
    "hardware/qcom-caf/wlan",
    'vendor/motorola/msm8998-common',
    "vendor/qcom/opensource/dataservices",
]

lib_fixups: lib_fixups_user_type = {
    libs_proto_3_9_1: lib_fixup_vendorcompat,
}

blob_fixups: blob_fixups_user_type = {
    'system/etc/permissions/com.motorola.mod.xml': blob_fixup()
        .regex_replace('mot_mod', 'oem_5020'),
    (
        'system/lib64/libvibratorhw.so',
        'system/lib64/motorola.hardware.vibrator@1.0.so',
    ): blob_fixup()
        .replace_needed('libhidlbase.so', 'libhidlbase-v32.so'),
    'system/lib64/libmodhw.so': blob_fixup()
        .add_needed('libnativehelper_shim.so')
        .replace_needed('libhidlbase.so', 'libhidlbase-v32.so'),
    'vendor/bin/charge_only_mode': blob_fixup()
        .add_needed('libmemset_shim.so'),
    'vendor/etc/init/android.hardware.biometrics.fingerprint@2.1-service.rc': blob_fixup()
        .regex_replace('system input', 'system uhid input'),
    (
        'vendor/bin/hw/motorola.hardware.health@1.0-service',
        'vendor/lib/com.motorola.mod@1.0_vendor.so',
        'vendor/lib/libmodmanager.so',
        'vendor/lib64/com.motorola.mod@1.0_vendor.so',
        'vendor/lib64/libmodmanager.so',
        'vendor/lib64/vendor.qti.hardware.tui_comm@1.0.so'
    ): blob_fixup()
        .replace_needed('libhidlbase.so', 'libhidlbase-v32.so')
        .replace_needed('libutils.so', 'libutils-v32.so'),
    'vendor/lib/libmmcamera2_pproc_modules.so': blob_fixup()
        .binary_regex_replace(b'\x70\x72\x6F\x64\x75\x63\x74\x2E\x6D\x61\x6E\x75', b'\x70\x72\x6F\x64\x75\x63\x74\x2E\x6E\x6F\x70\x65'),
    'vendor/lib/libzaf_core.so': blob_fixup()
        .binary_regex_replace(b'\x2f\x73\x79\x73\x74\x65\x6d\x2f\x65\x74\x63\x2f\x7a\x61\x66', b'\x2f\x76\x65\x6e\x64\x6f\x72\x2f\x65\x74\x63\x2f\x7a\x61\x66'),
    'vendor/lib/libtinyalsa-moto.so': blob_fixup()
        .fix_soname(),
    (
        'vendor/lib/libdualcameraddm.so',
        'vendor/lib/libmmcamera_hdr_gb_lib.so',
        'vendor/lib/libvideobokeh.so',
        'vendor/lib64/libdualcameraddm.so',
        'vendor/lib64/libvideobokeh.so'
    ): blob_fixup()
        .replace_needed('libstdc++.so', 'libstdc++_vendor.so'),
}  # fmt: skip

module = ExtractUtilsModule(
    'beckham',
    'motorola',
    namespace_imports=namespace_imports,
    blob_fixups=blob_fixups,
    lib_fixups=lib_fixups,
)

if __name__ == '__main__':
    utils = ExtractUtils.device_with_common(module, 'msm8998-common', module.vendor)
    utils.run()
