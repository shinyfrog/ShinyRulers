//
//  SFCursorBallonView.h
//  ShinyRuler
//
//  Created by Matteo Rattotti on 1/9/10.
//  Copyright 2010 www.shinyfrog.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface SFCursorBallonView : NSView {
    int currentValue;
    
    NSColor *initialColor;
    NSColor *finalColor;
    NSColor *strokeColor;
    NSGradient *bgGradient;
    
    BOOL orizontal;

}
- (void) setCurrentValue: (int) newValue;

@end
