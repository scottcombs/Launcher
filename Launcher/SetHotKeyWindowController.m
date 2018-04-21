//
//  SetHotKeyWindowController.m
//  Launcher
//
//  Created by Scott on 4/20/18.
//  Copyright © 2018 CrankySoft. All rights reserved.
//

#import "SetHotKeyWindowController.h"
#import "DDHotKeyTextField.h"
#import "DDHotKeyCenter.h"

@interface SetHotKeyWindowController ()

@end

@implementation SetHotKeyWindowController
@synthesize menuItem;

-(id)init {
	self = [super initWithWindowNibName:@"SetHotKeyWindowController"];
	if (self) {
		//self.window.windowController = self;
	}
	return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
	self.titleTextField.stringValue = self.menuItem.title;
	if (![self.menuItem.keyEquivalent isEqualToString:@""] && self.menuItem.keyEquivalentModifierMask != 0) {
		// Load existing hotkey
		unsigned int keyCode = [self.menuItem.keyEquivalent characterAtIndex:0];
		self.hotKeyTextField.hotKey = [DDHotKey hotKeyWithKeyCodeNoTask:keyCode modifierFlags:self.menuItem.keyEquivalentModifierMask];
	}
}

- (IBAction)clearHotKeyTextField:(id)sender {
	[self.hotKeyTextField setHotKey:nil];
}

@end
