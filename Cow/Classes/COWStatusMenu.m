//
//  COWStatusMenu.m
//  Cow
//
//  Created by Simon Hau on 13/11/11.
//  Copyright (c) 2011 SH. All rights reserved.
//

#import "COWStatusMenu.h"
#import "COWAppDelegate.h"

@implementation COWStatusMenu

- (id)init
{
    self = [super init];
    if (self) {
        NSMenuItem *menuItem = [[NSMenuItem alloc] init];
        [menuItem setTitle:@"↖ Drop the images on the icon"];
        [self addItem:menuItem];
        [menuItem release];
        
        /**/
        
        [self addItem:[NSMenuItem separatorItem]];
        
        menuItem = [[NSMenuItem alloc] init];
        [menuItem setTitle:@"25%"];
        [menuItem setState:NSOffState];
        [menuItem setTarget:self];
        [menuItem setAction:@selector(tmpMethod)];
        [self addItem:menuItem];
        [menuItem release];
        
        menuItem = [[NSMenuItem alloc] init];
        [menuItem setTitle:@"50%"];
        [menuItem setState:NSOnState];
        [menuItem setTarget:self];
        [menuItem setAction:@selector(tmpMethod)];
        [self addItem:menuItem];
        [menuItem release];

        /**/
        
        [self addItem:[NSMenuItem separatorItem]];
        
        menuItem = [[NSMenuItem alloc] init];
        [menuItem setTitle:@"Preferences"];
        [menuItem setTarget:(COWAppDelegate *)[[NSApplication sharedApplication] delegate]];
        [menuItem setAction:@selector(showPreferencesWindow)];
        [self addItem:menuItem];
        [menuItem release];
        
        /**/
        
        [self addItem:[NSMenuItem separatorItem]];
        
        menuItem = [[NSMenuItem alloc] init];
        [menuItem setTarget:NSApp];
        [menuItem setAction:@selector(terminate:)];
        [menuItem setTitle:@"Quit"];
        [self addItem:menuItem];
        [menuItem release];
    }
    return self;
}

@end
