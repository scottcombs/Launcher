//
//  SetHotKeyWindowController.h
//  Launcher
//
//  Created by Scott on 4/20/18.
//  Copyright © 2018 CrankySoft. All rights reserved.
//

#import <AppKit/AppKit.h>
@class DDHotKeyTextField;

@interface SetHotKeyWindowController : NSWindowController

@property (readwrite, retain)NSMenuItem* menuItem;
@property (strong) IBOutlet NSTextField *titleTextField;
@property (strong) IBOutlet DDHotKeyTextField *hotKeyTextField;

@end
