//
//  CheatSheetAddEditViewController.m
//  CheatSheet
//
//  Created by Andrew Homeyer on 6/16/10.
//  Copyright 2010 Near Infinity. All rights reserved.
//

#import "CheatSheetAddEditViewController.h"
#import "CheatSheet.h"
#import "CheatSheetListViewController.h"


@implementation CheatSheetAddEditViewController

@synthesize cheatSheet, cheatSheetListViewController, navigationBar, cheatSheetTableView, cheatSheetRow;

- (void)viewWillAppear:(BOOL) animated {
								 
	[super viewWillAppear:animated];
	
	if(!self.cheatSheet){
		self.navigationBar.topItem.title = @"New Cheat Sheet";
	} else {
		self.navigationBar.topItem.title = @"Edit Cheat Sheet";
	}
	[self.cheatSheetTableView reloadData];
}

- (void)saveAddEditDialog {
	
	UITableViewCell *titleCell = [self.cheatSheetTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
	NSString *title = ((UITextField*) titleCell.accessoryView).text;
	
	UITableViewCell *urlCell = [self.cheatSheetTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
	NSString *urlString = ((UITextField*) urlCell.accessoryView).text;
	NSURL *url = [NSURL URLWithString:urlString];
	
	CheatSheet *newCheatSheet = [[CheatSheet alloc] initWithTitle:title andURL:url];
	
	if(!self.cheatSheet){
		//add cheat sheet
		[self.cheatSheetListViewController addCheatSheet:newCheatSheet];
	} else {
		//replace existing cheat sheet
		[self.cheatSheetListViewController editCheatSheet:newCheatSheet atRow:self.cheatSheetRow];
	}
		
	[self dismissModalViewControllerAnimated:YES];

}

- (void)cancelAddEditDialog {
	[self dismissModalViewControllerAnimated:YES];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    //return (UITableViewCell *)[[NSArray arrayWithObjects:self.titleCell, self.urlCell, nil] objectAtIndex:indexPath.row];
	
	static NSString *CellIdentifier = @"AddEditCheatSheetCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	// Configure the cell.
	
	NSString *label = indexPath.row == 0? @"Title": @"URL";
	NSString *placeholder = indexPath.row == 0? @"Enter a title for the Cheat Sheet": @"http://example.com/cheatsheet.pdf";
	
	UIKeyboardType keyboardType = indexPath.row == 0? UIKeyboardTypeDefault: UIKeyboardTypeURL;
	
	UITextAutocapitalizationType autocapitalizationType = indexPath.row == 0? UITextAutocapitalizationTypeWords: UITextAutocapitalizationTypeNone;
	
	UITextField *textField = [[[UITextField alloc] initWithFrame:CGRectMake(0, 0, 400, 20)] autorelease];
	
	if(self.cheatSheet){
		textField.text = indexPath.row == 0? cheatSheet.title: [cheatSheet.url absoluteString];
	}
	
	textField.placeholder = placeholder;
	textField.keyboardType = keyboardType;
	textField.autocapitalizationType = autocapitalizationType;
	
	cell.accessoryView = textField;
    cell.textLabel.text = label;
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	[textField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventValueChanged];
	
    return cell;
	
}

- (void)textChanged:(UITextField *)source {
    //self.savedValue = source.text;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark -
#pragma mark Table view delegate
/*
- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
     //When a row is selected, set the detail view controller's detail item to the item associated with the selected row.
     
}
*/


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
