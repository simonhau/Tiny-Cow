//
//  COWImageHistoryMenuItem.h
//  Cow
//
//  Created by Simon Hau on 16/11/11.
//  Copyright (c) 2011 SH. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "COWImage.h"

@interface COWImageHistoryMenuItem : NSMenuItem

- (id)initWithImage:(COWImage *)image;

@end
