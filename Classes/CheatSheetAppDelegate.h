//
//  CheatSheetAppDelegate.h
//  CheatSheet
//
//  Created by Andrew Homeyer on 6/15/10.
//  Copyright Near Infinity 2010. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CheatSheetListViewController;
@class CheatSheetViewController;

@interface CheatSheetAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    
    UISplitViewController *splitViewController;
    
    CheatSheetListViewController *cheatSheetListViewController;
    CheatSheetViewController *cheatSheetViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UISplitViewController *splitViewController;
@property (nonatomic, retain) IBOutlet CheatSheetListViewController *cheatSheetListViewController;
@property (nonatomic, retain) IBOutlet CheatSheetViewController *cheatSheetViewController;

@end
