//
//  ResponsiveWindow.m
//  PomodoroSC
//
//  Created by Scott on 2/16/18.
//  Copyright © 2018 Nutz & Boltz Productions, LLC. All rights reserved.
//

#import "ResponsiveWindow.h"

@implementation ResponsiveWindow
@synthesize controller;
@synthesize returnCode;

- (BOOL)canBecomeKeyWindow{
	return YES;
}

- (BOOL)canBecomeMainWindow{
	return YES;
}

- (BOOL)worksWhenModal{
	return YES;
}

- (BOOL)isExcludedFromWindowsMenu{
	return NO;
}

- (IBAction)onOK:(id)sender {
	if (self.isSheet) {
		[self.sheetParent endSheet:self returnCode:NSModalResponseOK];
	}else{
		self.returnCode = NSModalResponseOK;
		[NSApp stopModalWithCode:NSModalResponseOK];
		[self orderOut:NULL];
	}
}

- (IBAction)onCancel:(id)sender {
	if (self.isSheet) {
		[self.sheetParent endSheet:self returnCode:NSModalResponseCancel];
	}else{
		self.returnCode = NSModalResponseCancel;
		[NSApp stopModalWithCode:NSModalResponseCancel];
		[self orderOut:NULL];
	}
}



@end
