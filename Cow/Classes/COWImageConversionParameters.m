//
//  COWImageConversionParameters.m
//  Cow
//
//  Created by Simon Hau on 19/11/11.
//  Copyright (c) 2011 SH. All rights reserved.
//

#import "COWImageConversionParameters.h"

@implementation COWImageConversionParameters

@synthesize resizeType;
@synthesize size;

- (id)init
{
    self = [super init];
    if (self) {
        resizeType = COWImageConversionResizeScale;
        size = NSZeroSize;
    }
    return self;
}

@end
