TARGET = iphone:13.5:13.0

export THEOS_DEVICE_IP=localhost
export THEOS_DEVICE_PORT=2222
ARCHS = arm64 arm64e
INSTALL_TARGET_PROCESSES = SpringBoard
FINALPACKAGE = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Haptic13

Haptic13_FILES = Tweak.x Haptics.m
Haptic13_CFLAGS = -fobjc-arc -Wno-return-type -Wno-objc-method-access -Wno-objc-property-no-attribute --target=arm64-apple-ios13.0
Haptic13_EXTRA_FRAMEWORKS += Cephei Foundation
Haptic13_LIBRARIES = sparkapplist

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += haptic13
include $(THEOS_MAKE_PATH)/aggregate.mk
