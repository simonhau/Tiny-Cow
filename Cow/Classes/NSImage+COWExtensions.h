//
//  NSImage+COWExtensions.h
//  Cow
//
//  Created by Simon Hau on 10/11/11.
//  Copyright (c) 2011 SH. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface NSImage (COWExtensions)

- (NSBitmapImageRep *)bitmapImageRep;
- (NSSize)actualSize;
- (BOOL)saveAtFilePath:(NSString *)aFilePath;

@end
