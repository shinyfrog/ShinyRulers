//
//  ShinyRulerController.h
//  ShinyRuler
//
//  Created by Matteo Rattotti on 1/8/10.
//  Copyright 2010 www.shinyfrog.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Carbon/Carbon.h>

@interface ShinyRulerController : NSObject {
    NSMutableArray *rulers;
}
- (void)mouseMoved;
@end
