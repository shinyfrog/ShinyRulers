//
//  SFRuler.h
//  ShinyRuler
//
//  Created by Matteo Rattotti on 1/7/10.
//  Copyright 2010 www.shinyfrog.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SFRulerOrientation.h"
#import "SFTranFadeWindow.h"
#import "SFRulerView.h"
#import "SFCursorBallonView.h"

@interface SFRuler : NSObject {

    SFTranFadeWindow *rulerWindow;
    SFRulerView *rulerView;
    SFTranFadeWindow *cursorWindow;
    SFCursorBallonView *ballonView;
    
    BOOL windowDragging;
    BOOL windowMoving;
    
}

#pragma mark -
#pragma mark Setup functions
- (void) setupCursorWindow;
- (void) setupObservers;

#pragma mark -
#pragma mark Ruler Management Functions
- (void) updateCursorMarkWithPoint: (NSPoint) markPoint;

@end
