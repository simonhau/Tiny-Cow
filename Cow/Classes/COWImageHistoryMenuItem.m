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
    NSString *historyName = [[image sourceFileName] lastPathComponent];
    self = [super initWithTitle:historyName action:@selector(clickedImageHistoryMenuItem) keyEquivalent:@""];
    if (self) {
        // FiXME
    }
    return self;
}

- (void)clickedImageHistoryMenuItem
{
    NSLog(@"clickedImageHistoryMenuItem");
}

@end
