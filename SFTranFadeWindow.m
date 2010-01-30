//
//  SFTranFadeWindow.m
//  SFToolkit
//
//  Created by Matteo Rattotti on 2/27/09.
//  Copyright 2009 www.shinyfrog.net. All rights reserved.
//

#import "SFTranFadeWindow.h"

@implementation SFTranFadeWindow

- (id)initWithContentRect:(NSRect)contentRect 
                styleMask:(unsigned int)aStyle 
                  backing:(NSBackingStoreType)bufferingType 
                    defer:(BOOL)flag {
    
    if (self = [super initWithContentRect:contentRect 
                                        styleMask: NSBorderlessWindowMask
                                          backing:NSBackingStoreBuffered   
                                   defer:NO]) {
                                   
        [self setLevel: NSStatusWindowLevel];
        [self setBackgroundColor: [NSColor clearColor]];
        [self setOpaque:NO];
        [self setMovableByWindowBackground:YES];
        [self setHasShadow:NO];
        
        return self;
    }
    
    return nil;
}

- (BOOL) canBecomeKeyWindow
{
    return YES;
}

- (IBAction)fadeOut:(id)sender {
    [self fadeOut];
}

- (IBAction)fadeIn:(id)sender {
    [self fadeIn];
}

- (void) fadeOut
{
    // Building the animation for the fade in
    NSDictionary *fadeIn;
    fadeIn = [NSDictionary dictionaryWithObjectsAndKeys:
                              self, NSViewAnimationTargetKey,
                              NSViewAnimationFadeOutEffect,
                              NSViewAnimationEffectKey, nil];


    // Creating array with all the animations
    NSArray *animations = [NSArray arrayWithObject:fadeIn];

    // Animation view
    NSViewAnimation *animation;
    animation = [[NSViewAnimation alloc] initWithViewAnimations: animations];

    // Starting animation and then releasing it
    [animation startAnimation];
    [animation release];

}


- (void) fadeIn
{
    // Building the animation for the fade in
    NSDictionary *fadeIn;
    fadeIn = [NSDictionary dictionaryWithObjectsAndKeys:
                              self, NSViewAnimationTargetKey,
                              NSViewAnimationFadeInEffect,
                              NSViewAnimationEffectKey, nil];


    // Creating array with all the animations
    NSArray *animations = [NSArray arrayWithObject:fadeIn];

    // Animation view
    NSViewAnimation *animation;
    animation = [[NSViewAnimation alloc] initWithViewAnimations: animations];

    // Starting animation and then releasing it
    [animation startAnimation];
    [animation release];
}

@end
