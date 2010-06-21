//
//  CheatSheetListViewController.h
//  CheatSheet
//
//  Created by Andrew Homeyer on 6/15/10.
//  Copyright Near Infinity 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CheatSheet, CheatSheetViewController, CheatSheetAddEditViewController;

@interface CheatSheetListViewController : UITableViewController {
    CheatSheetViewController *cheatSheetViewController;
	CheatSheetAddEditViewController *cheatSheetAddEditViewController;
	NSMutableArray *cheatSheets;
	NSString *documentFolderPath;
}

@property (nonatomic, retain) IBOutlet CheatSheetViewController *cheatSheetViewController;
@property (nonatomic, retain) IBOutlet CheatSheetAddEditViewController *cheatSheetAddEditViewController;
@property (nonatomic, retain) NSMutableArray *cheatSheets;
@property (nonatomic, retain) NSString *documentFolderPath;

-(IBAction) addCheatSheetAction;

-(void) addCheatSheet:(CheatSheet*) cheatSheet;
-(void) editCheatSheet:(CheatSheet *)newCheatSheet atRow:(int)row;

@end
