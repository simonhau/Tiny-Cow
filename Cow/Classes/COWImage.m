//
//  COWImage.m
//  Cow
//
//  Created by Simon Hau on 14/11/11.
//  Copyright (c) 2011 SH. All rights reserved.
//

#import "COWImage.h"

@interface COWImage ()
- (NSSize)sizeForParameters:(COWImageConversionParameters *)conversionParameters;
@end

@implementation COWImage

@synthesize sourceFileName, savedFileName;

- (id)initWithSourceImage:(COWImage *)aSourceImage size:(NSSize)aNewSize
{
    self = [[COWImage alloc] initWithSize:CGSizeMake(aNewSize.width, aNewSize.height)];
    if (self) {
        [self setCacheMode:NSImageCacheNever];
        self.sourceFileName = [aSourceImage sourceFileName];
        self.savedFileName = [aSourceImage savedFileName];
        NSLog(@"initWithContentsOfFile - sourceFileName = %@", sourceFileName);
        [self lockFocus];
        [aSourceImage drawInRect:NSMakeRect(0, 0, aNewSize.width, aNewSize.height) 
                       fromRect:NSMakeRect(0, 0, 0, 0) 
                      operation:NSCompositeSourceOver 
                       fraction:1.0];
        [self unlockFocus];
    }
    return self;
}

- (id)initWithContentsOfFile:(NSString *)aFileName parameters:(COWImageConversionParameters *)conversionParameters
{
    COWImage *sourceImage = [self initWithContentsOfFile:aFileName];
    if (sourceImage) {
        [sourceImage setSourceFileName:aFileName];
        NSSize newSize = [sourceImage sizeForParameters:conversionParameters];
        self = [[COWImage alloc] initWithSourceImage:sourceImage size:newSize];
    }
    return self;
}

- (void)dealloc
{
    self.sourceFileName = nil;
    self.savedFileName = nil;
    [super dealloc];
}

#pragma mark - Resize

- (NSSize)sizeForParameters:(COWImageConversionParameters *)conversionParameters
{
    NSSize size = [self actualSize];
    if ([conversionParameters resizeType] == COWImageConversionResizeScale) {
        size.width = size.width * conversionParameters.conversionSize.width;
        size.height = size.height * conversionParameters.conversionSize.height;
    }
    else if ([conversionParameters resizeType] == COWImageConversionResizeFixed) {
        size.width = conversionParameters.conversionSize.width;
        size.height = conversionParameters.conversionSize.height;        
    }
    
    size.width = round(size.width);
    size.height = round(size.height);
    
    return size;
}

#pragma mark - Save

- (BOOL)save
{
    NSString *filePathWithoutPathExtension = [sourceFileName stringByDeletingPathExtension];
    NSString *filePathExtension = [sourceFileName pathExtension];
    NSString *filePath = nil;
    NSInteger iteration = 1;
    
    // FiXME
    while (YES) {
        filePath = [filePathWithoutPathExtension stringByAppendingFormat:@"%@%@", 
                    [NSString stringWithFormat:@" (%i)", iteration],
                    (filePathExtension) ? [NSString stringWithFormat:@".%@", filePathExtension] : @""];
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath] == NO) {
            NSLog(@"saving in %@", filePath);
            break;
        }
        ++iteration;
    }
    
    if ((filePath) && ([self saveAtFilePath:filePath])) {
        self.savedFileName = filePath;
        return YES;
    }
    
    return NO;
}

@end
