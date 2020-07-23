#import <Foundation/Foundation.h>
#import <Cephei/HBPreferences.h>
#import <Preferences/PSListController.h>
#import <UIKit/UIKit.h>
#import <substrate.h>
#import "Haptics.h"
#import "SparkAppList.h"
#import "Tweak.h"

BOOL canLoadInto = false;
static bool Enabled;
static bool IconHaptics;
static bool TabBarHaptics;
static bool KeyboardHaptics;
static bool SwitcherHaptics;
static bool PassHaptics;
static bool TableHaptics;
static bool ScreenshotHaptics;
static bool VolumeHaptics;
static bool CCHaptics;
static bool NotiViewHaptics;


NSInteger stregnth = 0; // 0 - Light, 1 - Medium, 2 - Heavy, 3 - Rigid, 4 - Soft

void hapticWithBool(BOOL theBool){
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    	if (canLoadInto){
			if (Enabled){
				if (theBool){
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
	});
}

%hook UIKeyboardLayoutStar
- (void)touchDownWithKey:(id)arg1 atPoint:(CGPoint)arg2 executionContext:(id)arg3 {
	%orig(arg1, arg2, arg3);
	hapticWithBool(KeyboardHaptics);
	return;
}
%end

%hook UIKeyboardImpl
-(void)deleteBackward{
	%orig();
	hapticWithBool(KeyboardHaptics);
	return;
}
%end

%hook SBIconController 
- (void)iconManager:(id)arg1 possibleUserIconTapBegan:(id)arg2 {
	%orig(arg1, arg2);
	hapticWithBool(IconHaptics);
	return;
}
%end

%hook UITabBarButton
-(void)_setSelected:(BOOL)arg1{
	%orig(arg1);
	hapticWithBool(TabBarHaptics);
	return;
}
%end

%hook SBFluidSwitcherViewController
-(void)killContainer:(id)arg1 forReason:(long long)arg2{
	%orig(arg1, arg2);
	hapticWithBool(SwitcherHaptics);
	return;
}
%end

%hook SBDeckSwitcherViewController
-(void)didSelectContainer:(id)arg1 {
	%orig(arg1);
	hapticWithBool(SwitcherHaptics);
	return;
}
%end

%hook SBUIPasscodeLockNumberPad
-(void)_numberPadTouchDown:(id)arg1 forEvent:(id)arg2 {
	%orig(arg1, arg2);
	hapticWithBool(PassHaptics);
	return;
}
-(void)_numberPadTouchCancelled:(id)arg1 forEvent:(id)arg2 {
	%orig(arg1, arg2);
	hapticWithBool(PassHaptics);
	return;
}
-(void)_backspaceButtonHit {
	%orig();
	hapticWithBool(PassHaptics);
	return;
}
-(void)_cancelButtonHit {
	%orig();
	hapticWithBool(PassHaptics);
	return;
}
%end

%hook UIKeyboardEmojiCollectionViewCell
-(void)touchesBegan:(id)arg1 withEvent:(id)arg2 {
	%orig(arg1, arg2);
	//hapticWithBool(KeyboardHaptics);
	return;
}
%end

%hook UITableViewCell
-(void)touchesBegan:(id)arg1 withEvent:(id)arg2 {
	%orig(arg1,arg2);
	hapticWithBool(TabBarHaptics);
	return;
}
%end

%hook SpringBoard
-(void)takeScreenshot {
	%orig();
	hapticWithBool(ScreenshotHaptics);
	return;
}

-(void)_notificationCenterDidPresent {
	%orig();
	hapticWithBool(NotiViewHaptics);
	return;	
}
%end

%hook SBVolumeControl
-(void)increaseVolume {
	%orig();
	hapticWithBool(VolumeHaptics);
	return;
}
-(void)decreaseVolume {
	%orig();
	hapticWithBool(VolumeHaptics);
	return;
}
%end

%hook SBControlCenterController
-(void)grabberTongueBeganPulling:(id)arg1 withDistance:(double)arg2 andVelocity:(double)arg3 {
	%orig(arg1, arg2, arg3);
	hapticWithBool(CCHaptics);
	return;
}

-(void)_willBeginTransition {
	%orig();
	hapticWithBool(CCHaptics);
	return;	
}
%end

/*
	This does not work yet :(
*/
%hook SBCoverSheetPrimarySlidingViewController
-(void)grabberTongueBeganPulling:(id)arg1 withDistance:(double)arg2 andVelocity:(double)arg3 {
	%orig(arg1, arg2, arg3);
	hapticWithBool(NotiViewHaptics);
	return;
}
%end

void ReloadPrefs() {
	prefs = [[HBPreferences alloc] initWithIdentifier:@"org.brandonplank.haptic13"];
	if (!prefs){
		NSLog(@"[haptic13] ummmmm no prefs???");
	}
	Enabled = [([prefs objectForKey:@"HapticEnabled"] ?: @(YES)) boolValue];
	IconHaptics = [([prefs objectForKey:@"HapticIconHaptics"] ?: @(YES)) boolValue];
	TabBarHaptics = [([prefs objectForKey:@"HapticTabBarHaptics"] ?: @(YES)) boolValue];
	KeyboardHaptics = [([prefs objectForKey:@"HapticKeyboardHaptics"] ?: @(YES)) boolValue];
	SwitcherHaptics = [([prefs objectForKey:@"HapticSwitcherHaptics"] ?: @(YES)) boolValue];
	PassHaptics = [([prefs objectForKey:@"HapticPassHaptics"] ?: @(YES)) boolValue];
	TableHaptics = [([prefs objectForKey:@"HapticTableHaptics"] ?: @(YES)) boolValue];
	ScreenshotHaptics = [([prefs objectForKey:@"HapticScreenshotHaptics"] ?: @(YES)) boolValue];
	VolumeHaptics = [([prefs objectForKey:@"HapticVolumeHaptics"] ?: @(YES)) boolValue];
	CCHaptics = [([prefs objectForKey:@"HapticCCHaptics"] ?: @(YES)) boolValue];
	NotiViewHaptics = [([prefs objectForKey:@"HapticNotiViewHaptics"] ?: @(YES)) boolValue];
	stregnth = [[prefs objectForKey:@"HapticStrength"] floatValue];
}

%ctor{
	if ([[[[NSProcessInfo processInfo] arguments] objectAtIndex:0] containsString:@"SpringBoard.app"] || [[[[NSProcessInfo processInfo] arguments] objectAtIndex:0] containsString:@"/Application"]){
        //NSLog(@"[haptic13] We loading into %@", [[[NSProcessInfo processInfo] arguments] objectAtIndex:0]);
		NSString* bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    	if(![SparkAppList doesIdentifier:@"org.brandonplank.haptic13" andKey:@"excludedApps" containBundleIdentifier:bundleIdentifier] || [[[[NSProcessInfo processInfo] arguments] objectAtIndex:0] containsString:@"SpringBoard.app"]){
        	canLoadInto = true;
    	}
		if (canLoadInto) {
			ReloadPrefs();
			CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)ReloadPrefs, CFSTR("org.brandonplank.haptic13/ReloadPreferences"), NULL, kNilOptions);
		}
	    %init;
	} 
}