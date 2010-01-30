//
//  SFResizeControl.m
//  resizable
//
//  Created by Matteo rattotti on 1/9/08.
//  Copyright 2008 www.shinyfrog.net. All rights reserved.
//

#import "SFResizeControl.h"


@implementation SFResizeControl

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Setting the resize mask in order to maintain the control in place
        [self setAutoresizingMask:NSViewMinXMargin |  NSViewMinYMargin];
        
        if(frame.size.width <= frame.size.height)
            resizeCursor = [NSCursor resizeLeftRightCursor];
        else
            resizeCursor = [NSCursor resizeUpDownCursor];
    }
    
    return self;
}

- (void)drawRect:(NSRect)rect {

        /* NSBezierPath* resizeControlGraphics = [NSBezierPath bezierPath];
        
        float borderWidth = 1.0;
        
        [resizeControlGraphics setLineWidth:borderWidth];
        
        NSPoint upperRight = NSMakePoint(rect.origin.x-2, rect.size.height-2);
        NSPoint lowerLeft  = NSMakePoint(rect.size.width-2, rect.origin.y-2);
        
        [resizeControlGraphics moveToPoint:lowerLeft];
        
        [resizeControlGraphics lineToPoint:upperRight];
        
        [[NSColor colorWithCalibratedRed:0.42 green:0.42 blue:0.42 alpha:0.9]set];
        
        [resizeControlGraphics stroke]; */
        
        //[[NSColor colorWithCalibratedRed:0.42 green:0.42 blue:0.42 alpha:0.9]set];
        //NSRectFill(rect);

}

- (BOOL)isFlipped{
    return YES;
}



/* Resising window with the newSize size */
- (void)resizeWindowToSize: (NSSize)newSize
 {
    /* Don't resize less that the min or max window size*/
    NSSize minWinSize;
    NSSize maxWinSize;
     
     minWinSize = [[self window] minSize];
     maxWinSize = [[self window] maxSize];
     
     if (newSize.height < minWinSize.height) newSize.height = minWinSize.height;
     if (newSize.width < minWinSize.width) newSize.width = minWinSize.width;
     
     if (newSize.height > maxWinSize.height) newSize.height = maxWinSize.height;
     if (newSize.width > maxWinSize.width) newSize.width = maxWinSize.width;

     
    /* Getting old frame */
     NSRect aFrame;
     
     float newHeight = newSize.height;
     float newWidth = newSize.width;
     
     aFrame = [[self window] contentRectForFrameRect:[[self window] frame]];

    /* Setting new frame size */
     aFrame.origin.y += aFrame.size.height - newHeight;

     aFrame.size.height = newHeight;
     aFrame.size.width = newWidth;
     
     aFrame = [[self window] frameRectForContentRect:aFrame];
     
     /* Resizing */
     [[self window] setFrame:aFrame display:YES];
 }
 

#pragma mark -
#pragma mark Mouse handling functions 

- (BOOL)acceptsFirstMouse:(NSEvent *)theEvent {
    return YES;
}

- (BOOL)mouseDownCanMoveWindow{
    // We don't want to drag the window around
    return NO;
}

- (void) mouseDown:(NSEvent *) event{
    NSPoint clickPoint =  [self convertPoint:[event locationInWindow] fromView: nil];
    prevX = clickPoint.x;
    prevY = clickPoint.y;
    prevSize = [[self window] frame].size;
}

- (void) mouseUp:(NSEvent *) event{
    [[NSCursor arrowCursor]set];
}


- (void)mouseDragged:(NSEvent *)theEvent {
    [resizeCursor set];

    NSPoint dragPoint =  [self convertPoint:[theEvent locationInWindow] fromView: nil];
    
    NSSize winSize = [[self window] frame].size;
        
    // Getting difference caused by the drag
    float newX = dragPoint.x - prevX;
    float newY = dragPoint.y - prevY;
            
    NSSize newSize;
    
    // setting new size with the difference drag
    newSize.height = winSize.height + newY; 
    newSize.width = winSize.width + newX;
    
    // Resizing window
    [self resizeWindowToSize:newSize];
}

#pragma mark -
#pragma mark Tracking rect functions

- (void)setTrackingRect
{
        trackingRect = [self addTrackingRect:[self visibleRect] 
                                   owner:self 
                                userData:nil 
                            assumeInside:NO];
        
        // Setting cursors
        [self addCursorRect:[self visibleRect]  cursor:resizeCursor];
        [resizeCursor setOnMouseEntered:YES];

}

- (void)clearTrackingRect
{
	[self removeTrackingRect:trackingRect];
}

- (void)resetCursorRects
{
	[super resetCursorRects];
	[self clearTrackingRect];
	[self setTrackingRect];

}


@end
