//
//  COWStatusMenu.m
//  Cow
//
//  Created by Simon Hau on 13/11/11.
//  Copyright (c) 2011 SH. All rights reserved.
//

#import "COWStatusMenu.h"
#import "COWImageHistoryMenuItem.h"
#import "COWImageSizeMenuItem.h"
#import "COWImageManager.h"
#import "COWAppDelegate.h"

@interface COWStatusMenu ()
- (void)didConvertImage:(COWImage *)image;
- (void)selectSizeMenuItem:(COWImageSizeMenuItem *)sizeMenuItem;
@end

@implementation COWStatusMenu

@synthesize appDelegate;

- (id)initWithAppDelegate:(COWAppDelegate *)anAppDelegate
{
    self = [super init];
    if (self) {        
        self.appDelegate = anAppDelegate;
        
        NSMenuItem *menuItem = [[NSMenuItem alloc] init];
        [menuItem setTitle:@"↖ Drop the images on the icon"];
        [self addItem:menuItem];
        [menuItem release];
        
        historyDefaultIndex = [[self itemArray] count];
        historyIndex = historyDefaultIndex;
        
        /**/
        
        [self addItem:[NSMenuItem separatorItem]];
        
        COWImageSizeMenuItem *sizeMenuItem = nil;
        sizeMenuItem = [[COWImageSizeMenuItem alloc] initWithTitle:@"25%" 
                                                            action:@selector(selectSizeMenuItem:) 
                                                            target:self 
                                                        resizeType:COWImageConversionResizeScale 
                                                    conversionSize:NSMakeSize(0.25, 0.25)];
        [self addItem:sizeMenuItem];
        [sizeMenuItem release];
        
        sizeMenuItem = [[COWImageSizeMenuItem alloc] initWithTitle:@"50%" 
                                                            action:@selector(selectSizeMenuItem:) 
                                                            target:self 
                                                        resizeType:COWImageConversionResizeScale 
                                                    conversionSize:NSMakeSize(0.50, 0.50)];
        [self selectSizeMenuItem:sizeMenuItem];
        [self addItem:sizeMenuItem];
        [sizeMenuItem release];
        
        sizeMenuItem = [[COWImageSizeMenuItem alloc] initWithTitle:@"75%" 
                                                            action:@selector(selectSizeMenuItem:) 
                                                            target:self 
                                                        resizeType:COWImageConversionResizeScale 
                                                    conversionSize:NSMakeSize(0.75, 0.75)];
        [self addItem:sizeMenuItem];
        [sizeMenuItem release];

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

#pragma mark - Image Conversion Notification

- (void)didConvertImage:(NSNotification *)notification
{
    if ([[notification object] isKindOfClass:[COWImage class]]) {
        [self addImageHistory:[notification object]];
    }
}

#pragma mark - Images History

- (void)addImageHistory:(COWImage *)image;
{
    if (historyIndex == historyDefaultIndex) {
        [self insertItem:[NSMenuItem separatorItem] atIndex:historyDefaultIndex];
        ++historyIndex;
    }

    COWImage *thumbnailImage = [[COWImage alloc] initWithSourceImage:image size:NSMakeSize(18, 18)];
    COWImageHistoryMenuItem *imageHistoryMenuItem = [[COWImageHistoryMenuItem alloc] initWithImage:thumbnailImage];
    [thumbnailImage release];
    [self insertItem:imageHistoryMenuItem atIndex:historyIndex];
    [imageHistoryMenuItem release];
}

#pragma mark - Size Items Actions

- (void)selectSizeMenuItem:(COWImageSizeMenuItem *)sizeMenuItem
{
    for (NSMenuItem *menuItem in [self itemArray]) {
        if ([menuItem isKindOfClass:[COWImageSizeMenuItem class]]) {
            [menuItem setState:NSOffState];
        }
    }
    [sizeMenuItem setState:NSOnState];
    if ([appDelegate respondsToSelector:@selector(selectedSizeMenuItem:)]) {
        [appDelegate selectedSizeMenuItem:sizeMenuItem];
    }
}

@end
