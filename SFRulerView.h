//
//  SFRulerView.h
//  ShinyRuler
//
//  Created by Matteo rattotti on 12/17/07.
//  Copyright 2007 www.shinyfrog.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SFResizeControl.h"
#import "SFCursorView.h"

enum
 {
     SFRulerMarkPositionTop  = 1,
     SFRulerMarkPositionBottom = 2,
     SFRulerMarkPositionLeft = 3,
     SFRulerMarkPositionRight = 4
 };

@interface SFRulerView : NSView {
    float markDistance;
    float markHeight;
    float markMediumHeight;
    float markMediumSpace;
    float markBigHeight;
    float markBigSpace;

    NSTrackingRectTag trackingRect;

    NSColor *initialColor;
    NSColor *finalColor;
    NSGradient *bgGradient;

    BOOL orizontal;
    
    SFResizeControl *resizeView;
    SFCursorView *cursorView;

}
- (NSBezierPath *) rulerShape:(NSRect)rulerBounds;
- (NSBezierPath *) rulerMarkShape:(NSRect)rulerRect position:(int)rulerPosition;

- (NSPoint) tickSpace:(float)space tickHeight:(float)height position:(int)position;

- (void) drawMarkNumber:(NSRect)rulerRect;

- (BOOL) isOrizontal;

- (SFCursorView *) cursorView;

- (void)resetCursorRects;
- (void)clearTrackingRect;
- (void)setTrackingRect;


@end
