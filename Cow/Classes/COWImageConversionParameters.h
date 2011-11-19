//
//  COWImageConversionParameters.h
//  Cow
//
//  Created by Simon Hau on 19/11/11.
//  Copyright (c) 2011 SH. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
    COWImageConversionResizeNone,
    COWImageConversionResizeScale,
    COWImageConversionResizeFixed
};
typedef NSUInteger COWImageConversionResizeType;

@interface COWImageConversionParameters : NSObject
{
    COWImageConversionResizeType resizeType;
    NSSize conversionSize;
    // FiXME : other parameters (directory, etc.)
}

@property (nonatomic, assign) COWImageConversionResizeType resizeType;
@property (nonatomic, assign) NSSize conversionSize;

@end
