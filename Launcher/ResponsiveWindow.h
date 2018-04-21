//
//  ResponsiveWindow.h
//  PomodoroSC
//
//  Created by Scott on 2/16/18.
//  Copyright © 2018 Nutz & Boltz Productions, LLC. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface ResponsiveWindow : NSWindow{
}

@property (strong)__kindof NSWindowController* controller;
@property (readwrite)NSModalResponse returnCode;

- (IBAction)onOK:(id)sender;
- (IBAction)onCancel:(id)sender;

@end
