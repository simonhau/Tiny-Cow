//
//  COWStatusMenu.h
//  Cow
//
//  Created by Simon Hau on 13/11/11.
//  Copyright (c) 2011 SH. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "COWImage.h"

@class COWAppDelegate;

@interface COWStatusMenu : NSMenu
{
    NSUInteger historyIndex;
    NSUInteger historyDefaultIndex;
    COWAppDelegate *appDelegate;
}

@property (nonatomic, assign) COWAppDelegate *appDelegate;

- (id)initWithAppDelegate:(COWAppDelegate *)anAppDelegate;
- (void)addImageHistory:(COWImage *)image;

@end
