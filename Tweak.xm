#import "Tweak.h"

#if DEBUG
#define NSLog(args...) NSLog(@"[ForceCriticalAlerts] "args)
#else
#define NSLog(...);
#endif

static NSMutableDictionary *preferences = nil;

static BOOL alertIsCritical = NO;

static void loadPreferences(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
		preferences = [[NSMutableDictionary alloc] initWithContentsOfFile:[NSHomeDirectory() stringByAppendingFormat:@"/Library/Preferences/%s.plist", "com.toggleable.forcecriticalalerts"]];
}

%hook UNNotificationRequest

+(id)requestWithIdentifier:(id)arg1 pushPayload:(id)arg2 bundleIdentifier:(NSString*)bundleIdentifier {
	alertIsCritical = [[preferences objectForKey:bundleIdentifier] boolValue];

	return %orig;
}
 %end

%hook UNNotificationSound

-(BOOL)isCritical {
	if (alertIsCritical) {
		return YES;
	}

	return %orig;
}
%end

%hook BBSectionInfo
- (long long)criticalAlertSetting {
	if ([[preferences objectForKey:[self sectionID]] boolValue])
		return 2;

	return %orig;
}
%end

%ctor {
	loadPreferences(nil, nil, nil, nil, nil);

	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), nil, (CFNotificationCallback)loadPreferences, CFSTR("com.toggleable.forcecriticalalerts.preferencesUpdated"), nil, CFNotificationSuspensionBehaviorDeliverImmediately);
}
