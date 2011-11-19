//
//  COWImageHistoryMenuItem.m
//  Cow
//
//  Created by Simon Hau on 16/11/11.
//  Copyright (c) 2011 SH. All rights reserved.
//

#import "COWImageHistoryMenuItem.h"

@interface COWImageHistoryMenuItem ()
- (void)clickedImageHistoryMenuItem;
@end

@implementation COWImageHistoryMenuItem

- (id)initWithImage:(COWImage *)image
{
    self = [super init];
    if (self) {
        [self setTarget:self];
        [self setAction:@selector(clickedImageHistoryMenuItem)];
        
        NSView *menuItemView = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 280, 20)];
        
        NSText *text = [[NSText alloc] initWithFrame:NSMakeRect(16 + 18 + 2, 0, 280, 20)];
        [text setFont:[NSFont systemFontOfSize:14]];
        [text setString:[[image sourceFileName] lastPathComponent]];
        [text setBackgroundColor:[NSColor clearColor]];
        [menuItemView addSubview:text];
        [text release];
        
        NSImageView *imageView = [[NSImageView alloc] initWithFrame:NSMakeRect(16, 2, 18, 18)];
        [imageView setImage:image];
        [menuItemView addSubview:imageView];
        [imageView release];
        
        [self setView:menuItemView];
        [menuItemView release];
    }
    return self;
}

- (void)clickedImageHistoryMenuItem
{
    NSLog(@"clickedImageHistoryMenuItem");
}

@end
