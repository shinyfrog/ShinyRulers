//
//  SFCursorBallonView.m
//  ShinyRuler
//
//  Created by Matteo Rattotti on 1/9/10.
//  Copyright 2010 www.shinyfrog.net. All rights reserved.
//

#import "SFCursorBallonView.h"


@implementation SFCursorBallonView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        currentValue = -1;
        
        initialColor = [NSColor colorWithCalibratedRed:0.49 green:0.58 blue:0.65 alpha:1];
        finalColor = [NSColor colorWithCalibratedRed:0.69 green:0.74 blue:0.77 alpha:1];
        strokeColor = [[NSColor colorWithCalibratedRed:0.41 green:0.41 blue:0.41 alpha:0.9]retain];
        bgGradient = [[NSGradient alloc] initWithStartingColor:initialColor endingColor:finalColor];

        if(frame.size.width > frame.size.height)
            orizontal = YES;
    }
    return self;
}

- (void) dealloc{
    [bgGradient release];
    [strokeColor release];
    [super dealloc];
}

- (void)drawRect:(NSRect)rect {
    NSRect newFrame;// = NSInsetRect(rect, 1, 1);
    if(orizontal)
        newFrame = NSMakeRect(currentValue, 1, 58, 18);
    else
        newFrame = NSMakeRect(1, rect.size.height - currentValue - 22 , 58, 18);
        
    NSBezierPath *ballonBox = [NSBezierPath bezierPathWithRoundedRect:newFrame xRadius:9 yRadius:9];
    [bgGradient drawInBezierPath:ballonBox angle:90];
    [strokeColor set];
    [ballonBox stroke];
    
    NSString *valueString = [NSString stringWithFormat:@"%d", currentValue];
    
    NSFont *textFont = [NSFont fontWithName:@"Lucida Grande" size:10];
        
    NSMutableDictionary *textAttr = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     textFont, NSFontAttributeName,
                                     [NSColor whiteColor], NSForegroundColorAttributeName,
                                     nil];

    NSMutableDictionary *shadowTextAttr = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     textFont, NSFontAttributeName,
                                     [NSColor colorWithCalibratedRed:0.41 green:0.41 blue:0.41 alpha:1.0], NSForegroundColorAttributeName,
                                     nil];


    NSSize textSize = [valueString sizeWithAttributes:textAttr];

    NSPoint titleTextPoint;
    if(orizontal)
        titleTextPoint = NSMakePoint(newFrame.origin.x + (newFrame.size.width / 2.0) - (textSize.width / 2.0) , (newFrame.size.height - textSize.height)/2.0 + 1);
    else
        titleTextPoint = NSMakePoint(newFrame.origin.x + (newFrame.size.width / 2.0) - (textSize.width / 2.0) , rect.size.height - currentValue - 20);
    
    NSPoint shadowTextPoint = titleTextPoint;
    shadowTextPoint.y += 1;
    [valueString drawAtPoint:shadowTextPoint withAttributes:shadowTextAttr];
    [valueString drawAtPoint:titleTextPoint withAttributes:textAttr];

}

- (void) setCurrentValue: (int) newValue {
    currentValue = newValue;
    [self display];
}


@end
