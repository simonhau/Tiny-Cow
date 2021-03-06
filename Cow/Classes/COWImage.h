//
//  COWImage.h
//  Cow
//
//  Created by Simon Hau on 14/11/11.
//  Copyright (c) 2011 SH. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "NSImage+COWExtensions.h"
#import "COWImageConversionParameters.h"

@interface COWImage : NSImage
{
    NSString *sourceFileName;
    NSString *savedFileName;
}

@property (nonatomic, retain) NSString *sourceFileName;
@property (nonatomic, retain) NSString *savedFileName;

- (id)initWithSourceImage:(COWImage *)aSourceImage size:(NSSize)aNewSize;
- (id)initWithContentsOfFile:(NSString *)aFileName parameters:(COWImageConversionParameters *)conversionParameters;

- (BOOL)save;

@end