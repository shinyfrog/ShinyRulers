//
//  SFRuler.m
//  ShinyRuler
//
//  Created by Matteo Rattotti on 1/7/10.
//  Copyright 2010 www.shinyfrog.net. All rights reserved.
//

#import "SFRuler.h"
#import "SFResizeControl.h"

@implementation SFRuler

#pragma mark -
#pragma mark Constructors

- (id) initWithFrame:(NSRect)frame  {
    if (![super init])
        return nil;
    
    
    rulerView = [[SFRulerView alloc] initWithFrame:NSMakeRect(0, 0, frame.size.width, frame.size.height)];
    
    rulerWindow = [[SFTranFadeWindow alloc]initWithContentRect:frame styleMask:NSBorderlessWindowMask  backing:NSBackingStoreBuffered defer:NO];
    
    [rulerWindow setFrame:frame display:NO];
    [rulerWindow setMinSize:frame.size];
    
    if([rulerView isOrizontal])
        [rulerWindow setMaxSize:NSMakeSize(10000, frame.size.height)];
    else
        [rulerWindow setMaxSize:NSMakeSize(frame.size.width, 10000)];
        

    [rulerWindow setContentView:rulerView];
    [rulerView release];

    [self setupCursorWindow];
    [self setupObservers];

    [rulerWindow makeKeyAndOrderFront:self];
    

    windowDragging = NO;
    windowMoving = NO;
        
    
    return self;
}

#pragma mark -
#pragma mark Setup functions

- (void) setupCursorWindow{
    NSRect cursorWindowFrame;
    if([rulerView isOrizontal])
        cursorWindowFrame = NSMakeRect([rulerWindow frame].origin.x-30, [rulerWindow frame].size.height + [rulerWindow frame].origin.y + 5,  [rulerWindow frame].size.width+60, 20);
    else
        cursorWindowFrame = NSMakeRect([rulerWindow frame].origin.x-65, [rulerWindow frame].origin.y-15, 60, [rulerWindow frame].size.height+30);
        
    cursorWindow = [[SFTranFadeWindow alloc]initWithContentRect:cursorWindowFrame styleMask:NSBorderlessWindowMask  backing:NSBackingStoreBuffered defer:NO];

    [cursorWindow setMovableByWindowBackground:NO];
    
    ballonView = [[SFCursorBallonView alloc]initWithFrame:cursorWindowFrame];
    [cursorWindow setContentView:ballonView];
    [ballonView release];
    
    [rulerWindow addChildWindow:cursorWindow ordered:NSWindowAbove];
    [cursorWindow setAlphaValue:0];

}

- (void) setupObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                         selector:@selector(windowDidResized:) 
                                             name:NSWindowDidResizeNotification 
                                           object:rulerWindow];

    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                         selector:@selector(windowWillMove:) 
                                             name:NSWindowWillMoveNotification 
                                           object:rulerWindow];


    [[NSNotificationCenter defaultCenter] addObserver:self 
                                         selector:@selector(windowDidMove:) 
                                             name:NSWindowDidMoveNotification 
                                           object:rulerWindow];


    [[NSNotificationCenter defaultCenter] addObserver:self 
                                         selector:@selector(rulerMouseUp:) 
                                             name:@"SFRulerViewMouseUp"
                                           object:rulerView];

    [[NSNotificationCenter defaultCenter] addObserver:self 
                                         selector:@selector(rulerMouseDown:) 
                                             name:@"SFRulerViewMouseDown"
                                           object:rulerView];

}

#pragma mark -
#pragma mark Ruler Management Functions

- (void) windowDidResized: (id) sender{ 
    NSRect cursorWindowFrame;
    if([rulerView isOrizontal])
        cursorWindowFrame = NSMakeRect([rulerWindow frame].origin.x-30, [rulerWindow frame].size.height + [rulerWindow frame].origin.y + 5,  [rulerWindow frame].size.width+60, 20);
    else
        cursorWindowFrame = NSMakeRect([rulerWindow frame].origin.x-65, [rulerWindow frame].origin.y-15, 60, [rulerWindow frame].size.height+30);
    
    [cursorWindow setFrame:cursorWindowFrame display:YES];
}

- (void) windowWillMove: (id) sender { windowMoving = YES; }
- (void) windowDidMove: (id) sender  { windowMoving = NO; }
- (void) rulerMouseDown: (id) sender { windowDragging = YES; }
- (void) rulerMouseUp: (id) sender   { windowDragging = NO; [self performSelector:@selector(windowDidMove:) withObject:self afterDelay:0.1];}


- (void) updateCursorMarkWithPoint: (NSPoint) markPoint {
    
    if(windowDragging || windowMoving)
        return;
    
    float markerOriz = -1;
    float markerVer = -1;
    
    if([rulerView isOrizontal] && markPoint.x >= [rulerWindow frame].origin.x && markPoint.x <= [rulerWindow frame].origin.x + [rulerWindow frame].size.width){
        markerOriz = markPoint.x - [rulerWindow frame].origin.x;
        [[rulerView cursorView] setCurrentMark:markerOriz];
        [ballonView setCurrentValue: (int)markerOriz];
        [cursorWindow setAlphaValue:1];
    
       }
        
    else if(![rulerView isOrizontal] && markPoint.y >= [rulerWindow frame].origin.y && markPoint.y <= [rulerWindow frame].origin.y + [rulerWindow frame].size.height){
        markerVer = [rulerWindow frame].origin.y + [rulerWindow frame].size.height -markPoint.y;
        [[rulerView cursorView] setCurrentMark:markerVer];
        
        [ballonView setCurrentValue: (int)markerVer];
        [cursorWindow setAlphaValue:1];

        
        }
    else{
        [[rulerView cursorView] setCurrentMark:-1000000];
        [cursorWindow setAlphaValue:0];
    }
}

@end
