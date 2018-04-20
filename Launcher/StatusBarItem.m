//
//  MainToolBarItem.m
//  Launcher
//
//  Created by Scott on 4/18/18.
//  Copyright © 2018 CrankySoft. All rights reserved.
//

#import "StatusBarItem.h"
#import <ServiceManagement/ServiceManagement.h>
#import "DDHotKeyCenter.h"
#import <Carbon/Carbon.h>

@implementation StatusBarItem
@synthesize statusItem;
@synthesize menu;
@synthesize menuItems;
@synthesize hotkeyItems;
@synthesize pathToAppSupFolder;
@synthesize launchAtStartup;
@synthesize launchItem;

-(void)awakeFromNib{
	self.pathToAppSupFolder = [@"~/Library/Application Support/Launcher/" stringByExpandingTildeInPath];
	
	self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
	self.statusItem.highlightMode = YES;
	self.statusItem.title = @"";
	self.statusItem.enabled = YES;
	self.statusItem.toolTip = @"Launcher App";
	statusItem.image = [NSImage imageNamed:@"Launcher.png"];
	
	[self buildMenu:self];
	
}

- (IBAction)buildMenu:(id)sender {
	if (self.menu) {
		[self.menu removeAllItems];
	}else{
		self.menu = [[NSMenu alloc] init];
	}

	// Global hotkeys Array Check
	if (!self.hotkeyItems) {
		self.hotkeyItems = [[NSMutableArray alloc]init];
	}else{
		DDHotKeyCenter* hkc = [DDHotKeyCenter sharedHotKeyCenter];
		for (DDHotKey* hotKey in self.hotkeyItems) {
			[hkc unregisterHotKey:hotKey];
		}
		[self.hotkeyItems removeAllObjects];
	}

	//Add menu items
	// Sort the array
	NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
	[self.menuItems sortUsingDescriptors:[NSArray arrayWithObject:sort]];
	NSInteger count = 1;
	for (NSMenuItem* item in self.menuItems) {
		item.target = self;
		item.title = [item.title stringByReplacingOccurrencesOfString:@".app" withString:@""];
		NSImage* image = [self resizeImage:item.image width:18.0 height:18.0];
		item.image = image;
		
		item.keyEquivalent = [NSString stringWithFormat:@"%ld", count];
		item.keyEquivalentModifierMask = (NSEventModifierFlagCommand | NSEventModifierFlagOption);

		unsigned short keyCode = 0;
		switch (count){
			case 1:{
				keyCode = kVK_ANSI_1;
				break;
			}
			case 2:{
				keyCode = kVK_ANSI_2;
				break;
			}
			case 3:{
				keyCode = kVK_ANSI_3;
				break;
			}
			case 4:{
				keyCode = kVK_ANSI_4;
				break;
			}
			case 5:{
				keyCode = kVK_ANSI_5;
				break;
			}
			case 6:{
				keyCode = kVK_ANSI_6;
				break;
			}
			case 7:{
				keyCode = kVK_ANSI_7;
				break;
			}
			case 8:{
				keyCode = kVK_ANSI_8;
				break;
			}
			case 9:{
				keyCode = kVK_ANSI_9;
				break;
			}
			default:
				break;
		}

		// Register hotkey
		DDHotKeyCenter* hkc = [DDHotKeyCenter sharedHotKeyCenter];
		DDHotKey* hk = [hkc registerHotKeyWithKeyCode:keyCode modifierFlags:(NSEventModifierFlagCommand | NSEventModifierFlagOption) target:self action:@selector(handleHotKey:object:) object:item];
		[self.hotkeyItems addObject:hk];

		item.allowsKeyEquivalentWhenHidden = YES;
		NSMenu *submenu = [[NSMenu alloc] init];
		NSMenuItem* subMenuItem = [[NSMenuItem alloc]initWithTitle:@"Remove" action:@selector(removeMenuItem:) keyEquivalent:@""];
		subMenuItem.target = self;
		subMenuItem.representedObject = item;
		[submenu addItem:subMenuItem];
		[item setSubmenu:submenu];
		
		
		[self.menu addItem:item];
		count++;
	}
	
	// Common items that are always present
	[self.menu addItem:[NSMenuItem separatorItem]];
	
	self.launchItem = [[NSMenuItem alloc]init];
	self.launchItem.action = @selector(setAutoLaunch:);
	self.launchItem.target = self;
	self.launchItem.title = @"Launch At Startup";
	self.launchItem.state = self.launchAtStartup;
	[self.menu addItem:self.launchItem];
	
	NSMenuItem* addItem = [[NSMenuItem alloc] init];
	addItem.action = @selector(addItem:);
	addItem.target = self;
	addItem.title = @"Add Item...";
	addItem.keyEquivalent = @"";
	[self.menu addItem:addItem];
	
	NSMenuItem* aboutItem = [[NSMenuItem alloc] init];
	aboutItem.action = @selector(orderFrontStandardAboutPanel:);
	aboutItem.target = nil;
	aboutItem.title = @"About Launcher...";
	[self.menu addItem:aboutItem];
	
	[self.menu addItem:[NSMenuItem separatorItem]];
	
	NSMenuItem* exit = [[NSMenuItem alloc] init];
	exit.action = @selector(terminate:);
	exit.target = NSApp;
	exit.title = @"Exit";
	exit.keyEquivalent = @"";
	
	[self.menu addItem:exit];
	
	self.statusItem.menu = self.menu;
}

- (IBAction)removeMenuItem:(NSMenuItem*)sender {
	[self.menuItems removeObject:sender.representedObject];
	[self buildMenu:self];
}

- (NSImage*)resizeImage:(NSImage*)image width:(CGFloat)width height:(CGFloat)height{
	NSSize destSize = NSMakeSize(width, height);
	NSImage* newImage = [[NSImage alloc]initWithSize:destSize];
	[newImage lockFocus];
	[image drawInRect:NSMakeRect(0, 0, width, height) fromRect:NSMakeRect(0, 0, image.size.width, image.size.height) operation:NSCompositingOperationSourceOver fraction:1.0 respectFlipped:NO hints:NULL];
	[newImage unlockFocus];
	return [[NSImage alloc] initWithData:newImage.TIFFRepresentation];
}

- (IBAction)addItem:(id)sender {
	NSOpenPanel* panel = [NSOpenPanel openPanel];
	panel.canChooseDirectories = NO;
	panel.canCreateDirectories = NO;
	panel.allowsMultipleSelection = NO;
	panel.message = @"Add an item to Launcher.";
	
	NSInteger result = [panel runModal];
	if (result == NSModalResponseOK){
		NSURL* url = panel.URL;
		NSWorkspace* ws = [NSWorkspace sharedWorkspace];
		NSMenuItem* item = [[NSMenuItem alloc]init];
		item.action = @selector(launch:);
		item.target = self;
		item.image = [ws iconForFile:url.path];
		item.title = [url.path lastPathComponent];
		item.representedObject = url;
		[self.menuItems addObject:item];
		[self buildMenu:self];
	}
}

- (IBAction)loadMenuItems:(id)sender {
	NSFileManager* fm = [NSFileManager defaultManager];
	NSString* pathToMenuItems = [self.pathToAppSupFolder stringByAppendingString:@"/menuItems.bin"];
	
	if ([fm fileExistsAtPath:pathToMenuItems]) {
		//Open the file
		NSData* data = [NSData dataWithContentsOfFile:pathToMenuItems];
		self.menuItems = [NSKeyedUnarchiver unarchiveObjectWithData:data];
		[self buildMenu:self];
	}else{
		//Create the array
		self.menuItems = [[NSMutableArray alloc]init];
	}
}

- (IBAction)saveMenuItems:(id)sender {
	NSFileManager* fm = [NSFileManager defaultManager];
	NSString* pathToMenuItems = [self.pathToAppSupFolder stringByAppendingString:@"/menuItems.bin"];
	
	if ([fm fileExistsAtPath:pathToMenuItems]) {
		//Remove old file
		[fm removeItemAtPath:pathToMenuItems error:nil];
	}
	
	//Save the file
	NSData* data = [NSKeyedArchiver archivedDataWithRootObject:self.menuItems];
	[data writeToFile:pathToMenuItems atomically:NO];
}

- (IBAction)launch:(NSMenuItem*)sender {
	NSURL* url = sender.representedObject;
	NSWorkspace* ws = [NSWorkspace sharedWorkspace];
	[ws openURL:url];
}

- (IBAction) setAutoLaunch:(NSButton*)sender {
	NSString* appBundleIdentifier = @"com.crankysoft.LauncherStarter";
	self.launchAtStartup = !self.launchItem.state;
	if (SMLoginItemSetEnabled(CFBridgingRetain(appBundleIdentifier), self.launchAtStartup)) {
		if (self.launchAtStartup) {
			NSLog(@"%@", @"Successfully add login item.");
		} else {
			NSLog(@"%@", @"Successfully remove login item.");
		}
		self.launchItem.state = self.launchAtStartup;
	} else {
		NSLog(@"%@", @"Failed to add login item.");
	}
}

- (IBAction)handleHotKey:(id)sender object:(NSMenuItem*)menuItem {
	//NSLog(@"%@", @"Got Here");
	[self launch:menuItem];
}
@end