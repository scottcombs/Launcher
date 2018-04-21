/*
 DDHotKey -- DDHotKeyUtilities.m
 
 Copyright (c) Dave DeLong <http://www.davedelong.com>
 
 Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted, provided that the above copyright notice and this permission notice appear in all copies.
 
 The software is  provided "as is", without warranty of any kind, including all implied warranties of merchantability and fitness. In no event shall the author(s) or copyright holder(s) be liable for any claim, damages, or other liability, whether in an action of contract, tort, or otherwise, arising from, out of, or in connection with the software or the use or other dealings in the software.
 */

#import "DDHotKeyUtilities.h"
#import <Carbon/Carbon.h>
#import <AppKit/AppKit.h>

static NSDictionary *_DDKeyCodeToCharacterMap(void);
static NSDictionary *_DDKeyCodeToCharacterMap(void) {
    static NSDictionary *keyCodeMap = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        keyCodeMap = @{
                       @(kVK_Return) : @"↩",
                       @(kVK_Tab) : @"⇥",
                       @(kVK_Space) : @"⎵",
                       @(kVK_Delete) : @"⌫",
                       @(kVK_Escape) : @"⎋",
                       @(kVK_Command) : @"⌘",
                       @(kVK_Shift) : @"⇧",
                       @(kVK_CapsLock) : @"⇪",
                       @(kVK_Option) : @"⌥",
                       @(kVK_Control) : @"⌃",
                       @(kVK_RightShift) : @"⇧",
                       @(kVK_RightOption) : @"⌥",
                       @(kVK_RightControl) : @"⌃",
                       @(kVK_VolumeUp) : @"🔊",
                       @(kVK_VolumeDown) : @"🔈",
                       @(kVK_Mute) : @"🔇",
                       @(kVK_Function) : @"\u2318",
                       @(kVK_F1) : @"F1",
                       @(kVK_F2) : @"F2",
                       @(kVK_F3) : @"F3",
                       @(kVK_F4) : @"F4",
                       @(kVK_F5) : @"F5",
                       @(kVK_F6) : @"F6",
                       @(kVK_F7) : @"F7",
                       @(kVK_F8) : @"F8",
                       @(kVK_F9) : @"F9",
                       @(kVK_F10) : @"F10",
                       @(kVK_F11) : @"F11",
                       @(kVK_F12) : @"F12",
                       @(kVK_F13) : @"F13",
                       @(kVK_F14) : @"F14",
                       @(kVK_F15) : @"F15",
                       @(kVK_F16) : @"F16",
                       @(kVK_F17) : @"F17",
                       @(kVK_F18) : @"F18",
                       @(kVK_F19) : @"F19",
                       @(kVK_F20) : @"F20",
                       //                       @(kVK_Help) : @"",
                       @(kVK_ForwardDelete) : @"⌦",
                       @(kVK_Home) : @"↖",
                       @(kVK_End) : @"↘",
                       @(kVK_PageUp) : @"⇞",
                       @(kVK_PageDown) : @"⇟",
                       @(kVK_LeftArrow) : @"←",
                       @(kVK_RightArrow) : @"→",
                       @(kVK_DownArrow) : @"↓",
                       @(kVK_UpArrow) : @"↑",
					   @(kVK_ANSI_0) : @"0",
					   @(kVK_ANSI_1) : @"1",
					   @(kVK_ANSI_2) : @"2",
					   @(kVK_ANSI_3) : @"3",
					   @(kVK_ANSI_4) : @"4",
					   @(kVK_ANSI_5) : @"5",
					   @(kVK_ANSI_6) : @"6",
					   @(kVK_ANSI_7) : @"7",
					   @(kVK_ANSI_8) : @"8",
					   @(kVK_ANSI_9) : @"9",
					   @(kVK_ANSI_A) : @"A",
					   @(kVK_ANSI_B) : @"B",
					   @(kVK_ANSI_C) : @"C",
					   @(kVK_ANSI_D) : @"D",
					   @(kVK_ANSI_E) : @"E",
					   @(kVK_ANSI_F) : @"F",
					   @(kVK_ANSI_G) : @"G",
					   @(kVK_ANSI_H) : @"H",
					   @(kVK_ANSI_I) : @"I",
					   @(kVK_ANSI_J) : @"J",
					   @(kVK_ANSI_K) : @"K",
					   @(kVK_ANSI_L) : @"L",
					   @(kVK_ANSI_M) : @"M",
					   @(kVK_ANSI_N) : @"N",
					   @(kVK_ANSI_O) : @"O",
					   @(kVK_ANSI_P) : @"P",
					   @(kVK_ANSI_Q) : @"Q",
					   @(kVK_ANSI_R) : @"R",
					   @(kVK_ANSI_S) : @"S",
					   @(kVK_ANSI_T) : @"T",
					   @(kVK_ANSI_U) : @"U",
					   @(kVK_ANSI_V) : @"V",
					   @(kVK_ANSI_W) : @"W",
					   @(kVK_ANSI_X) : @"X",
					   @(kVK_ANSI_Y) : @"Y",
					   @(kVK_ANSI_Z) : @"Z",
					   @(kVK_ANSI_Comma) : @",",
					   @(kVK_ANSI_Period) : @".",
					   @(kVK_ANSI_Slash) : @"/",
					   @(kVK_ANSI_Semicolon) : @";",
					   @(kVK_ANSI_Quote) : @"'",
					   @(kVK_ANSI_LeftBracket) : @"[",
					   @(kVK_ANSI_RightBracket) : @"]",
					   @(kVK_ANSI_Backslash) : @"\""


                       };
    });
    return keyCodeMap;
}

NSString *DDStringFromKeyCode(unsigned short keyCode, NSUInteger modifiers) {
    NSMutableString *final = [NSMutableString stringWithString:@""];
    NSDictionary *characterMap = _DDKeyCodeToCharacterMap();
    
	if (modifiers & NSEventModifierFlagControl) {
        [final appendString:[characterMap objectForKey:@(kVK_Control)]];
    }
	if (modifiers & NSEventModifierFlagOption) {
        [final appendString:[characterMap objectForKey:@(kVK_Option)]];
    }
	if (modifiers & NSEventModifierFlagShift) {
        [final appendString:[characterMap objectForKey:@(kVK_Shift)]];
    }
	if (modifiers & NSEventModifierFlagCommand) {
        [final appendString:[characterMap objectForKey:@(kVK_Command)]];
    }
    
    if (keyCode == kVK_Control || keyCode == kVK_Option || keyCode == kVK_Shift || keyCode == kVK_Command) {
        return final;
    }
    
    NSString *mapped = [characterMap objectForKey:@(keyCode)];
    if (mapped != nil) {
        [final appendString:mapped];
    } else {
        
        TISInputSourceRef currentKeyboard = TISCopyCurrentKeyboardInputSource();
        CFDataRef uchr = (CFDataRef)TISGetInputSourceProperty(currentKeyboard, kTISPropertyUnicodeKeyLayoutData);
        
        // Fix crash using non-unicode layouts, such as Chinese or Japanese.
        if (!uchr) {
            CFRelease(currentKeyboard);
            currentKeyboard = TISCopyCurrentASCIICapableKeyboardLayoutInputSource();
            uchr = (CFDataRef)TISGetInputSourceProperty(currentKeyboard, kTISPropertyUnicodeKeyLayoutData);
        }
        
        const UCKeyboardLayout *keyboardLayout = (const UCKeyboardLayout*)CFDataGetBytePtr(uchr);
        
        if (keyboardLayout) {
            UInt32 deadKeyState = 0;
            UniCharCount maxStringLength = 255;
            UniCharCount actualStringLength = 0;
            UniChar unicodeString[maxStringLength];
            
            UInt32 keyModifiers = DDCarbonModifierFlagsFromCocoaModifiers(modifiers);
            
            OSStatus status = UCKeyTranslate(keyboardLayout,
                                             keyCode, kUCKeyActionDown, keyModifiers,
                                             LMGetKbdType(), 0,
                                             &deadKeyState,
                                             maxStringLength,
                                             &actualStringLength, unicodeString);
            
            if (actualStringLength > 0 && status == noErr) {
                NSString *characterString = [NSString stringWithCharacters:unicodeString length:(NSUInteger)actualStringLength];
                
                [final appendString:characterString];
            }
        }
    }
    
    return final;
}

unsigned int DDKeycodeFromString(NSString* code) {
	NSDictionary *characterMap = _DDKeyCodeToCharacterMap();
	NSArray *temp = [characterMap allKeysForObject:code];
	NSNumber* number = [temp lastObject];
	unsigned int key = number.unsignedIntValue;
	return key;
}

UInt32 DDCarbonModifierFlagsFromCocoaModifiers(NSUInteger flags) {
    UInt32 newFlags = 0;
	if ((flags & NSEventModifierFlagControl) > 0) { newFlags |= controlKey; }
	if ((flags & NSEventModifierFlagCommand) > 0) { newFlags |= cmdKey; }
	if ((flags & NSEventModifierFlagShift) > 0) { newFlags |= shiftKey; }
	if ((flags & NSEventModifierFlagOption) > 0) { newFlags |= optionKey; }
	if ((flags & NSEventModifierFlagCapsLock) > 0) { newFlags |= alphaLock; }
    return newFlags;
}
