//
//  SFRulerView.m
//  ShinyRuler
//
//  Created by Matteo rattotti on 12/17/07.
//  Copyright 2007 www.shinyfrog.net. All rights reserved.
//

#import "SFRulerView.h"
#import "SFResizeControl.h"

@implementation SFRulerView

#pragma mark -
#pragma mark Constructors

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    
        // Initializing color and gradient for the bg
        finalColor = [NSColor colorWithCalibratedRed:0.945 green:0.643 blue:0.286 alpha:0.85];
        initialColor = [NSColor colorWithCalibratedRed:0.972 green:0.980 blue:0.458 alpha:0.85];
        //initialColor = [NSColor colorWithCalibratedRed:0.90 green:0.90 blue:0.84 alpha:0.9];
        //finalColor = [NSColor colorWithCalibratedRed:0.68 green:0.71 blue:0.51 alpha:0.9];
        //initialColor = [NSColor colorWithCalibratedRed:0.98 green:1 blue:0.95 alpha:0.95];
        //finalColor = [NSColor colorWithCalibratedRed:0.69 green:0.74 blue:0.67 alpha:0.95];


        bgGradient = [[NSGradient alloc] initWithStartingColor:initialColor endingColor:finalColor];
        
        // Setting orientation mode
        if(frame.size.width > frame.size.height)
            orizontal = 1;
        else
            orizontal = 0;
        
        // Default setting
        markDistance = 2.0;      // Default mark distance   
        markHeight = 3.0;        // Default mark height
        markMediumHeight = 8.0;  // Mid mark height
        markMediumSpace = 10.0;  // Offset of mid mark 
        markBigHeight = 10.0;    // height of marks with number on it
        markBigSpace = 50.0;     // space between marks with number on it
                        
        // Adding the cursor view
        cursorView = [[SFCursorView alloc]initWithFrame:frame];
        [self addSubview:cursorView];
        [cursorView release];

        // Adding the resize control view
        NSRect resizeControlFrame;
        if(orizontal)
            resizeControlFrame = NSMakeRect([self frame].size.width -10.0, 0, 10.0, [self frame].size.height);
        else
            resizeControlFrame = NSMakeRect(0, [self frame].size.height -10.0, [self frame].size.width, 10);
        
        resizeView = [[SFResizeControl alloc]initWithFrame:resizeControlFrame];
        [self addSubview:resizeView];
        [resizeView release];
        
        // Setting behaviour when resizing the window
        if(orizontal)
            [self setAutoresizingMask:NSViewWidthSizable | NSViewMaxXMargin];
        else
            [self setAutoresizingMask:NSViewHeightSizable | NSViewMaxYMargin];

    }

    return self;
}

- (void) dealloc{
    [bgGradient release];
    [resizeView removeFromSuperview];
    [cursorView removeFromSuperview];
    [super dealloc];
}

#pragma mark -
#pragma mark View Properties

/* Is a orizontal or a vertical ruler*/
- (BOOL) isOrizontal{
    return orizontal;
}

/* The view is flipped */
- (BOOL)isFlipped{
    return YES;
}

- (BOOL)acceptsFirstMouse:(NSEvent *)theEvent {
    NSLog(@"accept");
    return YES;
}

#pragma mark -
#pragma mark Notification

-  (void)mouseUp:(NSEvent *)theEvent{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"SFRulerViewMouseUp" object:self];
}

-  (void)mouseDown:(NSEvent *)theEvent{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"SFRulerViewMouseDown" object:self];
}



- (void)mouseDragged:(NSEvent *)theEvent {
    [[NSApp delegate]mouseMoved];
}


#pragma mark -
#pragma mark Accessors

- (SFCursorView *) cursorView {
    return cursorView;
} 

#pragma mark -
#pragma mark Shapes functions

// Return the shape for the ruler
- (NSBezierPath *) rulerShape:(NSRect)rulerRect{

    NSBezierPath *rulerPath = [NSBezierPath bezierPathWithRect:rulerRect];
 
    float borderWidth = 2.0;
 
    [rulerPath setLineWidth:borderWidth];
    return rulerPath;
}

/* Returning mark point for an orizontal or vertical ruler */
- (NSPoint) tickSpace:(float)space tickHeight:(float)height position:(int)position{
    
    // Checking position and changing beaviour as needed
   if (position == SFRulerMarkPositionBottom) 
        height = [self frame].size.height - height;
   else if (position == SFRulerMarkPositionRight)
        height = [self frame].size.width - height;
    
    // Checking what kind of ruler we have
    if ([self isOrizontal]) 
        return NSMakePoint(space, height);
    else 
        return NSMakePoint(height, space);
}

/* Return shape with the marks on the ruler */
- (NSBezierPath *) rulerMarkShape:(NSRect)rulerRect position:(int)rulerPosition{
    NSBezierPath* markSteps = [NSBezierPath bezierPath];
    float borderWidth = 1.0;
 
    [markSteps setLineWidth:borderWidth];

    int tick;
    int tickWidth;
    
    if([self isOrizontal]) 
        tickWidth = rulerRect.size.width;
    else 
        tickWidth = rulerRect.size.height;
    
    int boffset = markDistance;
    int moffset = markDistance;
    
    
    for(tick=markDistance;tick< tickWidth; tick+=markDistance){
        [markSteps moveToPoint:[self tickSpace:tick tickHeight:0.0 position:rulerPosition]];
        if (boffset == markBigSpace){
            boffset =0;
            moffset = 0;
            [markSteps lineToPoint:[self tickSpace:tick tickHeight:markBigHeight position:rulerPosition]];
        }
        else if(moffset == markMediumSpace){
            moffset = 0;
            [markSteps lineToPoint:[self tickSpace:tick tickHeight:markMediumHeight position:rulerPosition]];

        }
        else
            [markSteps lineToPoint:[self tickSpace:tick tickHeight:markHeight position:rulerPosition]];

        boffset += markDistance;
        moffset += markDistance;
    }
        
    return markSteps;
}

#pragma mark -
#pragma mark Drawing functions

- (void) drawMarkNumber:(NSRect)rulerRect{
    NSString *number;
    
    // Setting font and attribute
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    //NSColor *fontColor = [NSColor colorWithCalibratedRed:0.33 green:0.33 blue:0.33 alpha:1.0];
    NSColor *fontColor = [NSColor colorWithCalibratedRed:0.1 green:0.1 blue:0.1 alpha:0.9];
    NSFont *font = [NSFont fontWithName:@"Lucida Grande" size:10.0];
    [attributes setObject:fontColor forKey:NSForegroundColorAttributeName];
    [attributes setObject:font forKey:NSFontAttributeName]; 

	NSColor *shadowColor = [NSColor colorWithCalibratedRed:1 green:0.9 blue:0.82 alpha:1.0];
	NSMutableDictionary *shadowAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
				  shadowColor, NSForegroundColorAttributeName,
				  font, NSFontAttributeName, nil];
	
	//[[self stringValue] drawInRect:NSOffsetRect(bounds, +2, +1) withAttributes:attributes];


    int tick;
    int width;
    NSPoint centerTick;
    
    if([self isOrizontal])
        width = rulerRect.size.width;
    else
        width = rulerRect.size.height;
        
    for(tick=markBigSpace;tick< width; tick+=markBigSpace){
        number = [NSString stringWithFormat:@"%d", tick];
        NSSize numberSize = [number sizeWithAttributes:attributes];
        if([self isOrizontal])
            centerTick = NSMakePoint(tick - numberSize.width/2, rulerRect.size.height / 2 - numberSize.height/2);
        else
            centerTick = NSMakePoint( rulerRect.size.width / 2 - numberSize.width/2, tick - numberSize.height/2);
        
        NSPoint shadowPoint = centerTick;
        shadowPoint.y +=1;
        [number drawAtPoint:shadowPoint withAttributes:shadowAttributes];
        [number drawAtPoint:centerTick withAttributes:attributes];
    }
}

- (void)drawRect:(NSRect)rect {    
    [[NSColor colorWithDeviceRed:0.4 green:0.4 blue:0.4 alpha:0.9]set];

    NSGraphicsContext* gc =  [NSGraphicsContext currentContext];
    [gc setShouldAntialias:NO];
    
    if([self isOrizontal]){
        [bgGradient drawInRect:rect angle:90.0];
        NSBezierPath *topMarks = [self rulerMarkShape:rect position:SFRulerMarkPositionTop];
        [topMarks stroke];
    
        NSBezierPath *bottomMarks = [self rulerMarkShape:rect position:SFRulerMarkPositionBottom];
        [bottomMarks stroke];
        }
    else{
        [bgGradient drawInRect:rect angle:180.0];

        NSBezierPath *topMarks = [self rulerMarkShape:rect position:SFRulerMarkPositionLeft];
        [topMarks stroke];
    
        NSBezierPath *bottomMarks = [self rulerMarkShape:rect position:SFRulerMarkPositionRight];
        [bottomMarks stroke];

    }
    [gc setShouldAntialias:YES];
    [NSBezierPath strokeRect:rect];
    [self drawMarkNumber:rect];
    
}


@end

