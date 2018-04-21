//
//  AppDelegate.h
//  Launcher
//
//  Created by Scott on 4/18/18.
//  Copyright © 2018 CrankySoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "StatusBarItem.h"
@class DDHotKey;

@interface AppDelegate : NSObject <NSApplicationDelegate>{
	IBOutlet StatusBarItem* statusBarItem;
}

@property (strong)StatusBarItem* statusBarItem;
@property (readwrite, retain)DDHotKey* hotKey;

@end

