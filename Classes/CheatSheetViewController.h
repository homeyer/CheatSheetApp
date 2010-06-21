//
//  CheatSheetViewController.h
//  CheatSheet
//
//  Created by Andrew Homeyer on 6/15/10.
//  Copyright Near Infinity 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CheatSheet;

@interface CheatSheetViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate> {
    
    UIPopoverController *popoverController;
    UIToolbar *toolbar;
    
    CheatSheet *cheatSheet;
    UIWebView *detailWebView;
}

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;

@property (nonatomic, retain) CheatSheet *cheatSheet;
@property (nonatomic, retain) IBOutlet UIWebView *detailWebView;

@end
