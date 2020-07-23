#include "BundleRootListController.h"
#import "SparkAppListTableViewController.h"
#import "../Tweak.h"

@implementation BundleRootListController

- (instancetype)init {
		self = [super init];
		if (self) {
			HBAppearanceSettings *appearanceSettings = [[HBAppearanceSettings alloc] init];
			appearanceSettings.tintColor = [UIColor colorWithRed:0.00 green:0.48 blue:1.00 alpha:1.0];
			appearanceSettings.tableViewCellSeparatorColor = [UIColor colorWithWhite:0 alpha:0];
			self.hb_appearanceSettings = appearanceSettings;
		}
		return self;
	}
	- (NSArray *)specifiers {
		if (!_specifiers) {
			_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
		}
		return _specifiers;
	}
	- (void)viewWillAppear:(BOOL)animated {
		[super viewWillAppear:animated];
		CGRect frame = self.table.bounds;
		frame.origin.y = -frame.size.height;
		[self.navigationController.navigationController.navigationBar setShadowImage: [UIImage new]];
		self.navigationController.navigationController.navigationBar.translucent = YES;
	}
	-(void)selectExcludeApps
	{
    	// Replace "com.spark.notchlessprefs" and "excludedApps" with your strings
    	SparkAppListTableViewController* s = [[SparkAppListTableViewController alloc] initWithIdentifier:@"org.brandonplank.haptic13" andKey:@"excludedApps"];

    	[self.navigationController pushViewController:s animated:YES];
    	self.navigationItem.hidesBackButton = FALSE;
		CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("org.brandonplank.haptic13/ReloadPreferences"), NULL, NULL, TRUE); 
	}
	-(void)donate{
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.cash.app/$brandonleeplank"]];
	}
	- (void)switchToggled:(UISwitch *)sender {
    	[([prefs objectForKey:@"HapticEnabled"] ?: @(YES)) boolValue];
    	[prefs synchronize];   
    	CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("org.brandonplank.haptic13/ReloadPreferences"), NULL, NULL, TRUE);        
    }

@end
