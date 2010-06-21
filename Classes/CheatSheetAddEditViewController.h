//
//  CheatSheetAddEditViewController.h
//  CheatSheet
//
//  Created by Andrew Homeyer on 6/16/10.
//  Copyright 2010 Near Infinity. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CheatSheet, CheatSheetListViewController;

@interface CheatSheetAddEditViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextInputTraits> {
	CheatSheet *cheatSheet;
	CheatSheetListViewController *cheatSheetListViewController;
	UINavigationBar *navigationBar;
	UITableView *cheatSheetTableView;
	int cheatSheetRow;
	
}

@property (nonatomic, retain) CheatSheet *cheatSheet;
@property (nonatomic, retain) IBOutlet CheatSheetListViewController *cheatSheetListViewController;
@property (nonatomic, retain) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, retain) IBOutlet UITableView *cheatSheetTableView;
@property int cheatSheetRow;

- (IBAction)saveAddEditDialog;
- (IBAction)cancelAddEditDialog;

@end
