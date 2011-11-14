//
//  NSImage+COWExtensions.m
//  Cow
//
//  Created by Simon Hau on 10/11/11.
//  Copyright (c) 2011 SH. All rights reserved.
//

#import "NSImage+COWExtensions.h"

@implementation NSImage (COWExtensions)

- (NSBitmapImageRep *)bitmapImageRep
{
    NSBitmapImageRep *bitmapImageRep = nil;
    for (NSImageRep *imageRep in [self representations]) {
        if ([imageRep isKindOfClass:[NSBitmapImageRep class]]) {
            bitmapImageRep = (NSBitmapImageRep *)imageRep;
            break;
        }
    }
    if (bitmapImageRep == nil) {
        bitmapImageRep = [NSBitmapImageRep imageRepWithData:[self TIFFRepresentation]];
    }
    
    return bitmapImageRep;
}

- (BOOL)saveAtFilePath:(NSString *)aFilePath
{    
    NSBitmapImageRep *bitmapImageRep = [self bitmapImageRep];
    if (bitmapImageRep) {
        NSData *imageData = [bitmapImageRep representationUsingType:NSJPEGFileType properties:nil];
        return [imageData writeToFile:aFilePath atomically:NO];    
    }
    return NO;
}

@end
