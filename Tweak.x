#import <Foundation/Foundation.h>
#import <Cephei/HBPreferences.h>
#import <Preferences/PSListController.h>
#import <UIKit/UIKit.h>
#import <substrate.h>
#import "Haptics.h"
#import "SparkAppList.h"

BOOL canLoadInto = false;
NSDictionary* prefs = nil;
static bool Enabled;
static bool IconHaptics;
static bool TabBarHaptics;
static bool KeyboardHaptics;
static bool SwitcherHaptics;

NSInteger stregnth = 0; // 0 - Light, 1 - Medium, 2 - Heavy, 3 - Rigid, 4 - Soft

%hook UIKeyboardLayoutStar
- (void)touchDownWithKey:(id)arg1 atPoint:(CGPoint)arg2 executionContext:(id)arg3 {
	%orig(arg1, arg2, arg3);
	if (canLoadInto){
		if (Enabled){
			if (KeyboardHaptics){
				if (stregnth == 0){
					[Haptics generateFeedback:FeedbackType_Impact_Light];
				} else if (stregnth == 1){
					[Haptics generateFeedback:FeedbackType_Impact_Medium];
				} else if (stregnth == 2){
					[Haptics generateFeedback:FeedbackType_Impact_Heavy];
				} else if (stregnth == 3){
					[Haptics generateFeedback:FeedbackType_Impact_Rigid];
				} else if (stregnth == 4){
					[Haptics generateFeedback:FeedbackType_Impact_Soft];
				}
			}
		}	
	}
	return;
}
%end

%hook SBIconController 
- (void)iconManager:(id)arg1 possibleUserIconTapBegan:(id)arg2 {
	%orig(arg1, arg2);
	if (canLoadInto){
		if (Enabled){
			if (IconHaptics){
				if (stregnth == 0){
					[Haptics generateFeedback:FeedbackType_Impact_Light];
				} else if (stregnth == 1){
					[Haptics generateFeedback:FeedbackType_Impact_Medium];
				} else if (stregnth == 2){
					[Haptics generateFeedback:FeedbackType_Impact_Heavy];
				} else if (stregnth == 3){
					[Haptics generateFeedback:FeedbackType_Impact_Rigid];
				} else if (stregnth == 4){
					[Haptics generateFeedback:FeedbackType_Impact_Soft];
				}
			}
		}	
	}
	return;
}
%end

%hook UITabBarButton
-(void)_setSelected:(BOOL)arg1{
	%orig(arg1);
	if (canLoadInto){
		if (Enabled){
			if (TabBarHaptics){
				if (stregnth == 0){
					[Haptics generateFeedback:FeedbackType_Impact_Light];
				} else if (stregnth == 1){
					[Haptics generateFeedback:FeedbackType_Impact_Medium];
				} else if (stregnth == 2){
					[Haptics generateFeedback:FeedbackType_Impact_Heavy];
				} else if (stregnth == 3){
					[Haptics generateFeedback:FeedbackType_Impact_Rigid];
				} else if (stregnth == 4){
					[Haptics generateFeedback:FeedbackType_Impact_Soft];
				}
			}
		}	
	}
	return;
}
%end

%hook UIKeyboardImpl
-(void)deleteBackward{
	%orig();
	if (canLoadInto){
		if (Enabled){
			if (KeyboardHaptics){
				if (stregnth == 0){
					[Haptics generateFeedback:FeedbackType_Impact_Light];
				} else if (stregnth == 1){
					[Haptics generateFeedback:FeedbackType_Impact_Medium];
				} else if (stregnth == 2){
					[Haptics generateFeedback:FeedbackType_Impact_Heavy];
				} else if (stregnth == 3){
					[Haptics generateFeedback:FeedbackType_Impact_Rigid];
				} else if (stregnth == 4){
					[Haptics generateFeedback:FeedbackType_Impact_Soft];
				}
			}
		}	
	}
	return;
}
%end

%hook SBFluidSwitcherViewController
-(void)killContainer:(id)arg1 forReason:(long long)arg2{
	%orig(arg1, arg2);
	if (canLoadInto){
		if (Enabled){
			if (SwitcherHaptics){
				if (stregnth == 0){
					[Haptics generateFeedback:FeedbackType_Impact_Light];
				} else if (stregnth == 1){
					[Haptics generateFeedback:FeedbackType_Impact_Medium];
				} else if (stregnth == 2){
					[Haptics generateFeedback:FeedbackType_Impact_Heavy];
				} else if (stregnth == 3){
					[Haptics generateFeedback:FeedbackType_Impact_Rigid];
				} else if (stregnth == 4){
					[Haptics generateFeedback:FeedbackType_Impact_Soft];
				}
			}
		}	
	}
	return;
}
%end

%hook SBDeckSwitcherViewController
-(void)didSelectContainer:(id)arg1 {
	%orig(arg1);
    if (canLoadInto){
		if (Enabled){
			if (SwitcherHaptics){
				if (stregnth == 0){
					[Haptics generateFeedback:FeedbackType_Impact_Light];
				} else if (stregnth == 1){
					[Haptics generateFeedback:FeedbackType_Impact_Medium];
				} else if (stregnth == 2){
					[Haptics generateFeedback:FeedbackType_Impact_Heavy];
				} else if (stregnth == 3){
					[Haptics generateFeedback:FeedbackType_Impact_Rigid];
				} else if (stregnth == 4){
					[Haptics generateFeedback:FeedbackType_Impact_Soft];
				}
			}
		}	
	}
	return;
}
%end

%ctor{
	if ([[[[NSProcessInfo processInfo] arguments] objectAtIndex:0] containsString:@"SpringBoard.app"] || [[[[NSProcessInfo processInfo] arguments] objectAtIndex:0] containsString:@"/Application"]){
        NSLog(@"[haptic13] We loading into %@", [[[NSProcessInfo processInfo] arguments] objectAtIndex:0]);
		HBPreferences *prefs = [[HBPreferences alloc] initWithIdentifier:@"org.brandonplank.haptic13"];
		if (!prefs){
			NSLog(@"[haptic13] ummmmm no prefs???");
		}
		NSString* bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];

		if ([[[[NSProcessInfo processInfo] arguments] objectAtIndex:0] containsString:@"SpringBoard.app"]){
			canLoadInto = true;
		}
    	if(![SparkAppList doesIdentifier:@"org.brandonplank.haptic13" andKey:@"excludedApps" containBundleIdentifier:bundleIdentifier]){
        	canLoadInto = true;
    	}
		Enabled = [([prefs objectForKey:@"HapticEnabled"] ?: @(YES)) boolValue];
		IconHaptics = [([prefs objectForKey:@"HapticIconHaptics"] ?: @(YES)) boolValue];
		TabBarHaptics = [([prefs objectForKey:@"HapticTabBarHaptics"] ?: @(YES)) boolValue];
		KeyboardHaptics = [([prefs objectForKey:@"HapticKeyboardHaptics"] ?: @(YES)) boolValue];
		SwitcherHaptics = [([prefs objectForKey:@"HapticSwitcherHaptics"] ?: @(YES)) boolValue];
		stregnth = [[prefs objectForKey:@"HapticStrength"] floatValue];
    } 
}

