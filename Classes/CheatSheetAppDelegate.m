//
//  CheatSheetAppDelegate.m
//  CheatSheet
//
//  Created by Andrew Homeyer on 6/15/10.
//  Copyright Near Infinity 2010. All rights reserved.
//

#import "CheatSheetAppDelegate.h"


#import "CheatSheetListViewController.h"
#import "CheatSheetViewController.h"


@implementation CheatSheetAppDelegate

@synthesize window, splitViewController, cheatSheetListViewController, cheatSheetViewController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch    
    
    // Add the split view controller's view to the window and display.
    [window addSubview:splitViewController.view];
    [window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [splitViewController release];
    [window release];
    [super dealloc];
}


@end

