include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ForceCriticalAlerts
ForceCriticalAlerts_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

SUBPROJECTS += forcecriticalalerts

include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "launchctl stop com.apple.backboardd"

