@interface UNNotificationSound : NSObject
-(BOOL)isCritical;
@end

@interface UNNotificationRequest
+(id)requestWithIdentifier:(id)arg1 pushPayload:(id)arg2 bundleIdentifier:(id)arg3;
@end

@interface BBSectionInfo : NSObject
@property (nonatomic,copy) NSString * sectionID;
-(long long)criticalAlertSetting;
@end
