//
//  AppDelegate.m
//  LauncherStarter
//
//  Created by Scott on 4/19/18.
//  Copyright © 2018 CrankySoft. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application
	NSArray *pathComponents = [[[NSBundle mainBundle] bundlePath] pathComponents];
	pathComponents = [pathComponents subarrayWithRange:NSMakeRange(0, [pathComponents count] - 4)];
	NSString *path = [NSString pathWithComponents:pathComponents];
	[[NSWorkspace sharedWorkspace] launchApplication:path];
	[NSApp terminate:nil];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
	// Insert code here to tear down your application
}


@end
