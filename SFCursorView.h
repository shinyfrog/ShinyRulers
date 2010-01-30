//
//  SFCursorView.h
//  ShinyRuler
//
//  Created by Matteo Rattotti on 1/7/10.
//  Copyright 2010 www.shinyfrog.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface SFCursorView : NSView {
    int currentMark;
    BOOL orizontal;
    BOOL locked;
}
- (void) setCurrentMark: (int) newMark;

@end
