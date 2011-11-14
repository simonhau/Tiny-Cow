//
//  COWImage.m
//  Cow
//
//  Created by Simon Hau on 14/11/11.
//  Copyright (c) 2011 SH. All rights reserved.
//

#import "COWImage.h"

@implementation COWImage

@synthesize sourceFileName;

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
    [super dealloc];
}

#pragma mark - Resize

- (COWImage *)resizedImage
{
    NSBitmapImageRep *bitmapImageRep = [self bitmapImageRep];
    if (bitmapImageRep) {
        // FiXME 
        NSInteger wide = [bitmapImageRep pixelsWide] / 2;
        NSInteger high = [bitmapImageRep pixelsHigh] / 2;
        return [self resizedImage:CGSizeMake(wide, high)];
    }
    return NO;
}

- (COWImage *)resizedImage:(NSSize)newSize
{
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
    
    if (filePath) {
        return [self saveAtFilePath:filePath];
    }
    
    return NO;
}

@end
