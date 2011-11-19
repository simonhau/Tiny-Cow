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
    COWImageConversionResizeFixed,
    COWImageConversionResizeScale
};
typedef NSUInteger COWImageConversionResizeType;

@interface COWImageConversionParameters : NSObject
{
    NSSize size;
    COWImageConversionResizeType resizeType;
    // FiXME : other parameters
}

@property (nonatomic, assign) COWImageConversionResizeType resizeType;
@property (nonatomic, assign) NSSize size;

@end
