//
//  COWStatusMenu.h
//  Cow
//
//  Created by Simon Hau on 13/11/11.
//  Copyright (c) 2011 SH. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "COWImage.h"

@interface COWStatusMenu : NSMenu
{
    NSUInteger historyIndex;
    NSUInteger historyDefaultIndex;
}

- (void)addImageHistory:(COWImage *)image;

@end
