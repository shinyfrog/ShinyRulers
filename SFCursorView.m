//
//  SFCursorView.m
//  ShinyRuler
//
//  Created by Matteo Rattotti on 1/7/10.
//  Copyright 2010 www.shinyfrog.net. All rights reserved.
//

#import "SFCursorView.h"


@implementation SFCursorView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        currentMark = -1000000;
        
        // Setting orientation mode
        if(frame.size.width > frame.size.height){
            orizontal = 1;
            [self setAutoresizingMask:NSViewWidthSizable | NSViewMaxXMargin];
        }
        else{
            orizontal = 0;
            [self setAutoresizingMask:NSViewHeightSizable | NSViewMaxYMargin];
        }

    }
    locked = NO;
    return self;
}

- (void)drawRect:(NSRect)rect {
    if(currentMark != -1000000 ) {
        
        NSBezierPath* markSteps = [NSBezierPath bezierPath];
        float borderWidth = 1.0;
        [markSteps setLineWidth:borderWidth];
        if(orizontal) {
            [markSteps moveToPoint:NSMakePoint(currentMark, [self frame].size.height)];
            [markSteps lineToPoint:NSMakePoint(currentMark, 0)];
        }
        else {
            [markSteps moveToPoint:NSMakePoint(0, currentMark)];
            [markSteps lineToPoint:NSMakePoint([self frame].size.width, currentMark)];
        }
        
        [[NSColor colorWithCalibratedRed:0.33 green:0.33 blue:0.33 alpha:1.0]set];
        
        NSGraphicsContext* gc =  [NSGraphicsContext currentContext];
        [gc setShouldAntialias:NO];

        [markSteps stroke];
    }

}

- (BOOL)acceptsFirstMouse:(NSEvent *)theEvent {
    return YES;
}


/* The view is flipped */
- (BOOL)isFlipped{
    return YES;
}

- (void) setCurrentMark: (int) newMark {
    currentMark = newMark;
    [self display];
}


@end
