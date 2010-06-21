//
//  CheatSheet.m
//  CheatSheet
//
//  Created by Andrew Homeyer on 6/15/10.
//  Copyright 2010 Near Infinity. All rights reserved.
//

#import "CheatSheet.h"


@implementation CheatSheet

@synthesize title, url;

-(id) initWithTitle:(NSString *) cheatSheetTitle andURL: (NSURL *) cheatSheetURL {
	if (self = [super init])
	{
		self.title = cheatSheetTitle;
		self.url = cheatSheetURL;
	}
	return self;
	
}

- (void) setUrl: (NSURL*) newUrl {
	
	//default to http:// if not there
	NSString *newURLString = [newUrl absoluteString];
	if(![newURLString hasPrefix:@"https://"] && ![newURLString hasPrefix:@"http://"] && ![newURLString hasPrefix:@"file://"]){
		newUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", newURLString]];
	}
	
    [url autorelease];
    url = [newUrl retain];
}

-(NSMutableDictionary*) toDictionary {
	NSMutableDictionary *cheatSheet = [[NSMutableDictionary alloc] init];
	[cheatSheet setObject:title forKey:@"title"];
	[cheatSheet setObject:[url absoluteString] forKey:@"url"];
	return cheatSheet;
}

@end
