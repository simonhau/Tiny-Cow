//
//  COWStatusItemView.h
//  Cow
//
//  Created by Simon Hau on 10/11/11.
//  Copyright (c) 2011 SH. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol COWStatusItemViewDelegate <NSObject>
- (void)didDragFiles:(NSArray *)files;
@end

@interface COWStatusItemView : NSView<NSMenuDelegate>
{
    NSStatusItem *statusItem;
    BOOL highlight;
    NSImage *image;
    NSImage *alternateImage;
    id<COWStatusItemViewDelegate> delegate;
}

@property (nonatomic, assign) NSStatusItem *statusItem;
@property (nonatomic, retain) NSImage *image;
@property (nonatomic, retain) NSImage *alternateImage;
@property (nonatomic, assign, getter=isHighlited) BOOL highlight;
@property (nonatomic, assign) id<COWStatusItemViewDelegate> delegate;

@end
