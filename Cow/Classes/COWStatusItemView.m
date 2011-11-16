//
//  COWStatusItemView.m
//  Cow
//
//  Created by Simon Hau on 10/11/11.
//  Copyright (c) 2011 SH. All rights reserved.
//

#import "COWStatusItemView.h"
#import "COWImage.h"
#import "COWImageManager.h"

@implementation COWStatusItemView

@synthesize image, alternateImage, highlight, statusItem;

- (id)init
{
    self = [super init];
    if (self) {
        [self registerForDraggedTypes:[NSArray arrayWithObjects: NSFilenamesPboardType, nil]];
        
        NSImage *anImage = [[NSImage imageNamed:@"menu_ico"] retain];    
        [anImage setSize:CGSizeMake(kCOWStatusItemWidth, kCOWStatusItemHeight)];
        [self setImage:anImage];
        [anImage release];
        
        NSImage *anAlternateImage = [[NSImage imageNamed:@"menu_ico_highlight"] retain];
        [anAlternateImage setSize:CGSizeMake(kCOWStatusItemWidth, kCOWStatusItemHeight)];
        [self setAlternateImage:anAlternateImage];
        [anAlternateImage release];
    }
    return self;
}

- (void)dealloc
{
    self.image = nil;
    self.alternateImage = nil;
    [super dealloc];
}

- (void)drawRect:(NSRect)rect
{
    NSImage *imageToDraw = nil;
    if (highlight == NO && image) {
        imageToDraw = image;
    }
    else if (highlight && alternateImage) {
        [[NSColor selectedMenuItemColor] set];
		[NSBezierPath fillRect:[self bounds]];
        imageToDraw = alternateImage;
    }
    [imageToDraw drawInRect:NSMakeRect(0, 0, imageToDraw.size.width, imageToDraw.size.height) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
}

#pragma mark - Accessors

- (void)setStatusItem:(NSStatusItem *)aStatusItem
{
	if (aStatusItem != statusItem)
	{
		statusItem = aStatusItem;
	}    
}

- (void)setImage:(NSImage *)anImage
{
	if (anImage != image)
	{
		[image release];
		image = [anImage copy];
		[self setNeedsDisplay:YES];
	}
}

- (void)setAlternateImage:(NSImage *)anAlternateImage
{
	if (anAlternateImage != alternateImage)
	{
		[alternateImage release];
		alternateImage = [anAlternateImage copy];
		[self setNeedsDisplay:YES];
	}
}

#pragma mark - NSMenuDelegate

- (void)menuDidClose:(NSMenu *)menu
{
	highlight = NO;
	[self setNeedsDisplay:YES];	
}

#pragma mark - Drag Events

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender
{
    return NSDragOperationCopy;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender 
{
//    NSDragOperation sourceDragMask = [sender draggingSourceOperationMask];
    NSPasteboard *pboard = [sender draggingPasteboard];
    if ( [[pboard types] containsObject:NSFilenamesPboardType] ) {
        NSArray *files = [pboard propertyListForType:NSFilenamesPboardType];
        COWImageManager *sharedImageManager = [COWImageManager sharedImageManager];
        [sharedImageManager resizeImagesFiles:files];
    }
    return YES;
}

#pragma mark - Mouse Events

- (void)mouseDown:(NSEvent *)theEvent
{
    highlight = YES;
    [self setNeedsDisplay:YES];
    [statusItem popUpStatusItemMenu:[statusItem menu]];
    highlight = NO;
}

- (void)mouseUp:(NSEvent *)theEvent
{

}


@end
