# Copyright (C) 2017 SscSPs
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

# Check for target product
ifeq (du_x3,$(TARGET_PRODUCT))

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit device configuration
$(call inherit-product, device/leeco/x3/device.mk)

# Inherit some common DU stuff.
$(call inherit-product, vendor/du/config/common_full_phone.mk)

# Release name
PRODUCT_RELEASE_NAME := x3

# Device display
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1080

# Override AOSP build properties
PRODUCT_NAME := du_x3
PRODUCT_DEVICE := x3
PRODUCT_BRAND := LeEco
PRODUCT_MODEL := LeEco Le 1S
PRODUCT_MANUFACTURER := LeEco
PRODUCT_RESTRICT_VENDOR_FILES := false

# Google client ID property.
PRODUCT_GMS_CLIENTID_BASE := android-leeco

# Build fingerprint from Indian variant.
PRODUCT_BUILD_PROP_OVERRIDES += \
     BUILD_FINGERPRINT=Letv/Le1s_IN/X3_HK:6.0/DHXOSOP5801911241S/1479990092:user/release-keys \
     PRIVATE_BUILD_DESC="full_x500-user 6.0 DHXOSOP5801911241S 1479990092 release-keys"

# DU Apps that are not included automatically
PRODUCT_PACKAGES += \
Apollo \
Browser \
messaging \
MusicFX \
Mms \
Exchange \
Email \
FMRadio \
Terminal \
WallpaperPicker \
OmniTorch \
DevCamera \
SoundRecorder \
BluetoothExt \
CellBroadcastReceiver

endif
