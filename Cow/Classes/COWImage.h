//
//  COWImage.h
//  Cow
//
//  Created by Simon Hau on 14/11/11.
//  Copyright (c) 2011 SH. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "NSImage+COWExtensions.h"

@interface COWImage : NSImage
{
    NSString *sourceFileName;
}

@property (nonatomic, retain) NSString *sourceFileName;

- (COWImage *)resizedImage;
- (COWImage *)resizedImage:(NSSize)newSize;
- (BOOL)save;

@end