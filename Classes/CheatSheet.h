//
//  CheatSheet.h
//  CheatSheet
//
//  Created by Andrew Homeyer on 6/15/10.
//  Copyright 2010 Near Infinity. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CheatSheet : NSObject {
	NSString *title;
	NSURL *url;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSURL *url;

-(id) initWithTitle:(NSString *) cheatSheetTitle andURL: (NSURL *) cheatSheetURL;
-(NSMutableDictionary*) toDictionary;

@end
