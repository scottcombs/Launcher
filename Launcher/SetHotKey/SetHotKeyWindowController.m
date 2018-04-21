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
#import "DDHotKeyUtilities.h"

@implementation SetHotKeyWindowController
@synthesize menuItem;
@synthesize originalValues;
@synthesize hotKeyTextField;
@synthesize titleTextField;

-(id)init {
	self = [super initWithWindowNibName:@"SetHotKeyWindowController"];
	if (self) {
		// Should be able to see the NSWindowController
	}
	return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
	self.originalValues = [self.menuItem copy];

    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
	self.titleTextField.stringValue = self.menuItem.title;
	if (![self.menuItem.keyEquivalent isEqualToString:@""] && self.menuItem.keyEquivalentModifierMask != 0) {
		// Load existing hotkey
		unsigned int keyCode = DDKeycodeFromString(self.menuItem.keyEquivalent);
		self.hotKeyTextField.hotKey = [DDHotKey hotKeyWithKeyCodeNoTask:keyCode modifierFlags:self.menuItem.keyEquivalentModifierMask];
	}
}

- (IBAction)clearHotKeyTextField:(id)sender {
	self.menuItem.keyEquivalent = @"";
	self.menuItem.keyEquivalentModifierMask = 0;
	self.hotKeyTextField.hotKey = NULL;
}

- (IBAction)resetMenuItem:(id)sender {
	self.menuItem.keyEquivalent = self.originalValues.keyEquivalent;
	self.menuItem.keyEquivalentModifierMask = self.originalValues.keyEquivalentModifierMask;
}
@end
