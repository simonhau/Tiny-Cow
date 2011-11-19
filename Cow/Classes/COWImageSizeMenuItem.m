//
//  COWImageSizeMenuItem.m
//  Cow
//
//  Created by Simon Hau on 18/11/11.
//  Copyright (c) 2011 SH. All rights reserved.
//

#import "COWImageSizeMenuItem.h"

@implementation COWImageSizeMenuItem

@synthesize resizeType, conversionSize;

- (id)initWithTitle:(NSString *)aString action:(SEL)aSelector target:(id)aTarget resizeType:(COWImageConversionResizeType)aResizeType conversionSize:(NSSize)aConversionSize
{
    self = [super initWithTitle:aString action:aSelector keyEquivalent:@""];
    if (self) {
        self.target = aTarget;
        resizeType = aResizeType;
        conversionSize = aConversionSize;
    }
    return self;
}

@end
