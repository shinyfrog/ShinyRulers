//
//  SFResizeControl.h
//  resizable
//
//  Created by Matteo rattotti on 1/9/08.
//  Copyright 2008 www.shinyfrog.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface SFResizeControl : NSView {
    float prevX;
    float prevY;
    NSSize prevSize;
        
    NSCursor *resizeCursor;
    NSTrackingRectTag trackingRect;

}
- (void)resizeWindowToSize: (NSSize)newSize;


- (void)resetCursorRects;
- (void)clearTrackingRect;
- (void)setTrackingRect;

@end
