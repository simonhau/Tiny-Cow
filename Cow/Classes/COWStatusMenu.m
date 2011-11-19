//
//  COWStatusMenu.m
//  Cow
//
//  Created by Simon Hau on 13/11/11.
//  Copyright (c) 2011 SH. All rights reserved.
//

#import "COWStatusMenu.h"
#import "COWImageHistoryMenuItem.h"
#import "COWImageManager.h"

@interface COWStatusMenu ()
- (void)didConvertImage:(COWImage *)image;
@end

@implementation COWStatusMenu

- (id)init
{
    self = [super init];
    if (self) {        
        NSMenuItem *menuItem = [[NSMenuItem alloc] init];
        [menuItem setTitle:@"↖ Drop the images on the icon"];
        [self addItem:menuItem];
        [menuItem release];
        
        historyDefaultIndex = [[self itemArray] count];
        historyIndex = historyDefaultIndex;
        
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
        [menuItem setTarget:[[NSApplication sharedApplication] delegate]];
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

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didConvertImage:) name:COWImageManagerDidConvertImageNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObject:self];
    [super dealloc];
}

#pragma mark - 

- (void)didConvertImage:(NSNotification *)notification
{
    if ([[notification object] isKindOfClass:[COWImage class]]) {
        [self addImageHistory:[notification object]];
    }
}

- (void)addImageHistory:(COWImage *)image;
{
    if (historyIndex == historyDefaultIndex) {
        [self insertItem:[NSMenuItem separatorItem] atIndex:historyDefaultIndex];
        ++historyIndex;
    }
    
    COWImageHistoryMenuItem *imageHistoryMenuItem = [[COWImageHistoryMenuItem alloc] initWithImage:image];
    if (imageHistoryMenuItem) {
        [self insertItem:imageHistoryMenuItem atIndex:historyIndex];
        ++historyIndex;
    }
}

@end
