//
//  COWImage.m
//  Cow
//
//  Created by Simon Hau on 14/11/11.
//  Copyright (c) 2011 SH. All rights reserved.
//

#import "COWImage.h"

@implementation COWImage

@synthesize sourceFileName, savedFileName;

- (id)initWithContentsOfFile:(NSString *)aFileName
{
    self = [super initWithContentsOfFile:aFileName];
    if (self) {
        self.sourceFileName = aFileName;
        NSLog(@"initWithContentsOfFile - sourceFileName = %@", sourceFileName);
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

- (NSSize)actualSize
{
    NSSize actualSize = NSZeroSize;
    NSBitmapImageRep *bitmapImageRep = [self bitmapImageRep];
    if (bitmapImageRep) {
        actualSize.width = [bitmapImageRep pixelsWide];
        actualSize.height = [bitmapImageRep pixelsHigh];
    }
    return actualSize;
}

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
    return size;
}

- (COWImage *)convertedImage:(COWImageConversionParameters *)conversionParameters
{
    NSSize newSize = [self sizeForParameters:conversionParameters];
    newSize.width = round(newSize.width);
    newSize.height = round(newSize.height);
    COWImage *resizedImage = [[[COWImage alloc] initWithSize:CGSizeMake(newSize.width, newSize.height)] autorelease];
    [resizedImage setSourceFileName:self.sourceFileName];
    [resizedImage lockFocus];
    [self drawInRect:NSMakeRect(0, 0, newSize.width, newSize.height) 
            fromRect:NSMakeRect(0, 0, self.size.width, self.size.height) 
           operation:NSCompositeSourceOver 
            fraction:1.0];
    [resizedImage unlockFocus];

    return resizedImage;
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
