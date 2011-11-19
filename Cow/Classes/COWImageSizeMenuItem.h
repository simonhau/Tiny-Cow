//
//  COWImageSizeMenuItem.h
//  Cow
//
//  Created by Simon Hau on 18/11/11.
//  Copyright (c) 2011 SH. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "COWImageConversionParameters.h"

@interface COWImageSizeMenuItem : NSMenuItem
{
    COWImageConversionResizeType resizeType;
    NSSize conversionSize;
}

- (id)initWithTitle:(NSString *)aString action:(SEL)aSelector target:(id)aTarget resizeType:(COWImageConversionResizeType)aResizeType conversionSize:(NSSize)aConversionSize;

@property (nonatomic, assign) COWImageConversionResizeType resizeType;
@property (nonatomic, assign) NSSize conversionSize;

@end
