# Inherit some common Lineage stuff.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Device
$(call inherit-product, device/motorola/beckham/device.mk)

# Device identifiers
BUILD_FINGERPRINT := motorola/beckham/beckham:9/PPWS29.131-27-1-27/34b6d:user/release-keys
PRODUCT_BRAND := motorola
PRODUCT_DEVICE := beckham
PRODUCT_MANUFACTURER := motorola
PRODUCT_MODEL := Moto Z3 Play
PRODUCT_NAME := lineage_beckham

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=beckham \
    PRIVATE_BUILD_DESC="beckham-user 9 PPWS29.131-27-1-27 34b6d release-keys"
