//
//  AppDelegate.m
//  Launcher
//
//  Created by Scott on 4/18/18.
//  Copyright © 2018 CrankySoft. All rights reserved.
//

#import "AppDelegate.h"
#import <Carbon/Carbon.h>
#import "DDHotKeyCenter.h"

@implementation AppDelegate
@synthesize statusBarItem;
@synthesize hotKey;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application
	[NSApp setActivationPolicy: NSApplicationActivationPolicyAccessory];
	
	NSFileManager* fm = [NSFileManager defaultManager];
	if(![fm fileExistsAtPath:self.statusBarItem.pathToAppSupFolder]){
		[fm createDirectoryAtPath:self.statusBarItem.pathToAppSupFolder withIntermediateDirectories:NO attributes:NULL error:NULL];
	}
	
	[self loadDefaults:self];
	[self.statusBarItem loadMenuItems:self];
	
	[self loadListener:self];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
	// Insert code here to tear down your application
	[self.statusBarItem saveMenuItems:self];
	[self saveDefaults:self];
}

- (IBAction)loadDefaults:(id)sender {
	NSUserDefaults* prefs = [NSUserDefaults standardUserDefaults];
	if (![prefs boolForKey:@"launchAtStartup"]) {
		[prefs setBool:NO forKey:@"launchAtStartup"];
	}
	
	self.statusBarItem.launchAtStartup = [prefs boolForKey:@"launchAtStartup"];
}

- (IBAction)saveDefaults:(id)sender {
	NSUserDefaults* prefs = [NSUserDefaults standardUserDefaults];
	
	[prefs setBool:self.statusBarItem.launchAtStartup forKey:@"launchAtStartup"];
}

- (IBAction)loadListener:(id)sender {
//	DDHotKeyCenter *hkc = [DDHotKeyCenter sharedHotKeyCenter];
//	self.hotKey = [hkc registerHotKeyWithKeyCode: kVK_ANSI_2  modifierFlags:(NSEventModifierFlagCommand | NSEventModifierFlagOption) target:self.statusBarItem action:@selector(handleHotKey:)];
//
//	if (self.hotKey) {
//		NSLog(@"%@",@"All cool.");
//	}
}


@end
