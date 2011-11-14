//
//  COWAppDelegate.h
//  Cow
//
//  Created by Simon Hau on 12/11/11.
//  Copyright (c) 2011 SH. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "COWStatusMenu.h"

@interface COWAppDelegate : NSObject <NSApplicationDelegate>
{
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSButton *cleanHistoryPreferencesButton;
@property (assign) IBOutlet NSMatrix *savePreferencesMatrix;

@end
