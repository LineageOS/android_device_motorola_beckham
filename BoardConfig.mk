#
# Copyright (C) 2017 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Inherit from motorola sdm660-common
-include device/motorola/sdm660-common/BoardConfigCommon.mk

DEVICE_PATH := device/motorola/beckham

# A/B updater
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    system \
    vendor

# Assertions
TARGET_OTA_ASSERT_DEVICE := beckham

# Audio
TARGET_EXCLUDES_AUDIOFX := true

# Display
TARGET_SCREEN_DENSITY := 420

# Kernel
TARGET_KERNEL_CONFIG := lineageos_beckham_defconfig

# HIDL
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/motomods.xml

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3187671040
BOARD_VENDORIMAGE_PARTITION_SIZE := 939524096

# Power
TARGET_HAS_NO_WLAN_STATS := true

# RIL
ENABLE_VENDOR_RIL_SERVICE := true

# SELinux
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy-mods/private
SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy-mods/public
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy-mods/vendor

# inherit from the proprietary version
include vendor/motorola/beckham/BoardConfigVendor.mk
