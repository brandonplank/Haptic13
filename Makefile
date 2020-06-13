export THEOS_DEVICE_IP=localhost
export THEOS_DEVICE_PORT=2222
ARCHS = arm64 arm64e
INSTALL_TARGET_PROCESSES = SpringBoard
FINALPACKAGE = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Haptic13

Haptic13_FILES = Tweak.x Haptics.m
Haptic13_CFLAGS = -fobjc-arc -Wno-return-type -Wno-objc-method-access -Wno-objc-property-no-attribute -mios-version-min=13.0
Haptic13_EXTRA_FRAMEWORKS += Cephei
Haptic13_LIBRARIES = sparkapplist

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += haptic13
include $(THEOS_MAKE_PATH)/aggregate.mk
