//
//  ShinyRulerController.m
//  ShinyRuler
//
//  Created by Matteo Rattotti on 1/8/10.
//  Copyright 2010 www.shinyfrog.net. All rights reserved.
//

#import "ShinyRulerController.h"
#import "SFRuler.h"

@implementation ShinyRulerController

EventHandlerRef trackMouseGlobal;
EventHandlerRef trackMouseApp;

OSStatus mouseActivated(EventHandlerCallRef nextHandler, EventRef theEvent, void *userData)
{
   [[NSApp delegate] mouseMoved];
   return CallNextEventHandler(nextHandler, theEvent);
}

OSStatus appMouseActivated(EventHandlerCallRef nextHandler, EventRef theEvent, void *userData)
{
   [[NSApp delegate] mouseMoved];
   return CallNextEventHandler(nextHandler, theEvent);
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification{
    //Add in a global handler
    EventTypeSpec globalEventType[2];
    globalEventType[0].eventClass = kEventClassMouse;
    globalEventType[0].eventKind = kEventMouseMoved;
    globalEventType[1].eventClass = kEventClassMouse;
    globalEventType[1].eventKind = kEventMouseDragged;
   
    EventHandlerUPP globalHandlerFunction = NewEventHandlerUPP(mouseActivated);
    /*OSStatus result = */ InstallEventHandler(GetEventMonitorTarget(), globalHandlerFunction, 2, globalEventType, NULL, &trackMouseGlobal);
        
    EventHandlerUPP appHandlerFunction = NewEventHandlerUPP(appMouseActivated);
    /*OSStatus result = */ InstallEventHandler(GetApplicationEventTarget(), appHandlerFunction, 2, globalEventType, NULL, &trackMouseApp);


    // Setting up a pair of rulers    
    SFRuler *vertRuler = [[SFRuler alloc] initWithFrame:NSMakeRect(200, 200, 50, 400)];
    SFRuler *orizRuler = [[SFRuler alloc] initWithFrame:NSMakeRect(200, 200, 400, 50)];

    rulers = [[NSMutableArray arrayWithObjects:vertRuler, orizRuler, nil]retain];
    
    [vertRuler release]; [orizRuler release];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification{
    RemoveEventHandler(trackMouseGlobal);
    [rulers release];
}


- (void)mouseMoved {
    NSPoint mousePoint =[NSEvent mouseLocation];
    SFRuler *ruler;
    for(ruler in rulers)
        [ruler updateCursorMarkWithPoint:mousePoint];
}



@end
