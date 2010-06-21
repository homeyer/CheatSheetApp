//
//  CheatSheetListViewController.m
//  CheatSheet
//
//  Created by Andrew Homeyer on 6/15/10.
//  Copyright Near Infinity 2010. All rights reserved.
//

#import "CheatSheetListViewController.h"
#import "CheatSheetViewController.h"
#import "CheatSheetAddEditViewController.h"
#import "CheatSheet.h"


@interface CheatSheetListViewController ()
- (void) loadSavedCheatSheets;
-(void) saveCheatSheetsToDisk;
@end


@implementation CheatSheetListViewController

@synthesize cheatSheetViewController, cheatSheetAddEditViewController, cheatSheets, documentFolderPath;


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
	
	[self loadSavedCheatSheets];
		
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
	
	//a user can select a row to edit it in editing mode
	self.tableView.allowsSelectionDuringEditing = YES;
	
	self.cheatSheetAddEditViewController.cheatSheetListViewController = self;
	self.cheatSheetAddEditViewController.modalPresentationStyle = UIModalPresentationFormSheet;
		
}

- (void) loadSavedCheatSheets {
		
	//get cheat sheet manifest, which holds information about saved cheat sheets
	NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	self.documentFolderPath = [searchPaths objectAtIndex:0];
	
	NSString *pathToCheatSheetManifest = [self.documentFolderPath stringByAppendingPathComponent:@"CheatSheetManifest"];
	
	//build from file, if file exists
	if([[NSFileManager defaultManager] fileExistsAtPath:pathToCheatSheetManifest]){
		NSMutableArray *savedCheatSheetManifest = [NSMutableArray arrayWithContentsOfFile:pathToCheatSheetManifest];
		NSMutableArray *savedCheatSheets = [[NSMutableArray alloc] init];
		
		for(int i=0; i<[savedCheatSheetManifest count]; i++){
			NSMutableDictionary *cheatSheetAsDictionary = [savedCheatSheetManifest objectAtIndex:i];
			CheatSheet *cheatSheetFromDisk = [[CheatSheet alloc] initWithTitle:[cheatSheetAsDictionary objectForKey:@"title"] andURL:[NSURL URLWithString:[cheatSheetAsDictionary objectForKey:@"url"]]];
			[savedCheatSheets addObject:cheatSheetFromDisk];
		}
		
		self.cheatSheets = savedCheatSheets;
	} else {
		//we don't have a manifest, therefore we need to create the original list of cheat sheets and save it to disk
		
		CheatSheet *xCodeCheatSheet = [[CheatSheet alloc] initWithTitle:@"Xcode" andURL:[NSURL URLWithString: @"http://s3.amazonaws.com/pragmaticstudio/XcodeShortcuts.pdf"]];
		CheatSheet *prototypejsCheatSheet = [[CheatSheet alloc] initWithTitle:@"Prototype JS" andURL:[NSURL URLWithString: @"http://perfectionkills.com/downloads/Prototype%20Cheat%20Sheet%201.6.0.2"]];
		CheatSheet *gitCheatSheet = [[CheatSheet alloc] initWithTitle:@"Git" andURL:[NSURL URLWithString:@"http://ktown.kde.org/~zrusin/git/git-cheat-sheet-large.png"]];
		
		NSMutableArray *originalCheatSheets = [NSMutableArray arrayWithObjects:xCodeCheatSheet, prototypejsCheatSheet, gitCheatSheet, nil];
				
		self.cheatSheets = originalCheatSheets;
		
		[self saveCheatSheetsToDisk];
	}
	
}

//takes self.cheatSheets and saves it to disk as a list of dictionaries
-(void) saveCheatSheetsToDisk {
	
	
	//save actual cheat sheets to disk, and change URL from url resource to file resource
	//naming cheat sheet on disk by it's URL
	for(int i=0; i<[self.cheatSheets count]; i++){
		
		//TODO - figure out a better way to determine file extension. Maybe just download and try to load, display it in a smaller UIWebView
		//in the add/edit view, and ask the user to confirm before continuing.
		
		NSString *lastPathComponent = [[[[self.cheatSheets objectAtIndex:i] url] absoluteString] lastPathComponent];
		
		NSLog(@"path extension: %@", [[[[self.cheatSheets objectAtIndex:i] url] absoluteString] pathExtension]);
		
		//local file storage breaks if it doesn't have an extension. Assume PDF, if one of the following not given.
		if(![lastPathComponent hasSuffix:@".pdf"] && ![lastPathComponent hasSuffix:@".png"] && ![lastPathComponent hasSuffix:@".jpg"] && ![lastPathComponent hasSuffix:@".svg"]){
			lastPathComponent = [NSString stringWithFormat:@"%@%@", lastPathComponent, @".pdf"];
		}
		   
		NSString *pathToCheatSheet = [self.documentFolderPath stringByAppendingPathComponent:lastPathComponent];
		
		if(![[NSFileManager defaultManager] fileExistsAtPath:pathToCheatSheet]){
			NSData *data = [NSData dataWithContentsOfURL:[[self.cheatSheets objectAtIndex:i] url]];
			[data writeToFile:pathToCheatSheet atomically:YES];
			
			[[self.cheatSheets objectAtIndex:i] setUrl: [NSURL fileURLWithPath: pathToCheatSheet]];
		}
		
	}
	
	NSString *pathToCheatSheetManifest = [self.documentFolderPath stringByAppendingPathComponent:@"CheatSheetManifest"];

	NSMutableArray *cheatSheetManifest = [[NSMutableArray alloc] init];
	for(int i=0; i<[self.cheatSheets count]; i++){
		[cheatSheetManifest addObject: [[self.cheatSheets objectAtIndex:i] toDictionary]];
		
	}
	
	[cheatSheetManifest writeToFile:pathToCheatSheetManifest atomically:YES];
}

- (void) addCheatSheetAction {
	self.cheatSheetAddEditViewController.cheatSheet = nil;
	[self presentModalViewController:self.cheatSheetAddEditViewController animated:YES];
}

-(void) addCheatSheet:(CheatSheet *) newCheatSheet {
	//add new cheat sheet to array
	[self.cheatSheets addObject:newCheatSheet];
	
	//add row to bottom of table view
	[self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:[self.tableView numberOfRowsInSection:0] inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
	
	[self saveCheatSheetsToDisk];
	
}

-(void) editCheatSheet:(CheatSheet *)newCheatSheet atRow:(int)row {
	
	[self.cheatSheets replaceObjectAtIndex:row withObject:newCheatSheet];
	
	[self.tableView reloadData];
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/

// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.cheatSheets count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    // Dequeue or create a cell of the appropriate type.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    // Configure the cell.
	
	CheatSheet *cheatSheet = [self.cheatSheets objectAtIndex:indexPath.row];
															   
    cell.textLabel.text = cheatSheet.title;
    return cell;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		
        // Delete row from the data source
		[self.cheatSheets removeObjectAtIndex:indexPath.row];
		
		//TODO - load the starting resource if we just deleted the current one
		//[self.cheatSheetViewController.detailWebView loadRequest:xxx];
		
		//delete row from the table
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
		
		[self saveCheatSheetsToDisk];
    }  
}



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

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //if editing, show editing dialog. Otherwise, show cheat sheet
	if(self.tableView.editing){
		self.cheatSheetAddEditViewController.cheatSheet = [cheatSheets objectAtIndex:indexPath.row];
		self.cheatSheetAddEditViewController.cheatSheetRow = indexPath.row;
		[self presentModalViewController:self.cheatSheetAddEditViewController animated:YES];
	} else {
		self.cheatSheetViewController.cheatSheet = [cheatSheets objectAtIndex:indexPath.row];
	}
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [cheatSheetViewController release];
    [super dealloc];
}


@end

