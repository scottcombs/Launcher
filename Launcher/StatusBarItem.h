//
//  StatusBarItem.h
//  Launcher
//
//  Created by Scott on 4/18/18.
//  Copyright © 2018 CrankySoft. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface StatusBarItem : NSObject

@property (readwrite, retain)NSStatusItem* statusItem;
@property (readwrite, retain)NSMenu* menu;
@property (readwrite, retain)NSMutableArray* menuItems;
@property (readwrite, retain)NSMutableArray* hotkeyItems;
@property (readwrite, retain)NSMenuItem* launchItem;
@property (readwrite, retain)NSString* pathToAppSupFolder;
@property (readwrite)BOOL launchAtStartup;

- (IBAction)buildMenu:(id)sender;
- (IBAction)loadMenuItems:(id)sender;
- (IBAction)saveMenuItems:(id)sender;
- (IBAction)addItem:(id)sender;
- (IBAction)removeMenuItem:(NSMenuItem*)sender;
- (NSImage*)resizeImage:(NSImage*)image width:(CGFloat)width height:(CGFloat)height;
- (IBAction)handleHotKey:(id)sender object:(NSMenuItem*)menuItem;

@end
