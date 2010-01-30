//
//  SFTranFadeWindow.h
//  SFToolkit
//
//  Created by Matteo Rattotti on 2/27/09.
//  Copyright 2009 www.shinyfrog.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SFTranFadeWindow : NSWindow
{
}
- (void) fadeIn;
- (void) fadeOut;
- (IBAction)fadeOut:(id)sender;
- (IBAction)fadeIn:(id)sender;
@end
