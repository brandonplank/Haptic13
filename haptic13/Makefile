include $(THEOS)/makefiles/common.mk

ARCHS = arm64 arm64e
BUNDLE_NAME = Haptic13

Haptic13_FILES = BundleRootListController.m
Haptic13_INSTALL_PATH = /Library/PreferenceBundles
Haptic13_FRAMEWORKS = UIKit
Haptic13_PRIVATE_FRAMEWORKS = Preferences 
Haptic13_EXTRA_FRAMEWORKS += Cephei CepheiPrefs
Haptic13_LIBRARIES = sparkapplist
Haptic13_CFLAGS = -fobjc-arc -Wno-error -Wno-unused-variable

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/Haptic13.plist$(ECHO_END)
