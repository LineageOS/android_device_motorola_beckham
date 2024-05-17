#
# Copyright (C) 2017-2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Must set these before including common config
TARGET_BOARD_PLATFORM := sdm660
TARGET_BOOTLOADER_BOARD_NAME := SDM660
TARGET_SUPPORTS_MOTO_MODS := true

# Inherit from motorola msm8998-common
include device/motorola/msm8998-common/BoardConfigCommon.mk

DEVICE_PATH := device/motorola/beckham

# A/B updater
AB_OTA_PARTITIONS += \
    boot \
    system \
    vendor

AB_OTA_UPDATER := true

# Assertions
TARGET_BOARD_INFO_FILE := $(DEVICE_PATH)/board-info.txt
TARGET_OTA_ASSERT_DEVICE := beckham

# Display
TARGET_SCREEN_DENSITY := 420

# Kernel
BOARD_KERNEL_CMDLINE += androidboot.boot_devices=soc/c0c4000.sdhci
TARGET_KERNEL_CONFIG := lineageos_beckham_defconfig

# HIDL
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/beckham_manifest.xml

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3187671040
BOARD_VENDORIMAGE_PARTITION_SIZE := 939524096

# Power
TARGET_HAS_NO_WLAN_STATS := true

# Properties
TARGET_SYSTEM_EXT_PROP += $(DEVICE_PATH)/system_ext.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# inherit from the proprietary version
include vendor/motorola/beckham/BoardConfigVendor.mk
