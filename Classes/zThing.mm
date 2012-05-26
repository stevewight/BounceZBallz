//
//  zThing.m
//  bounceZballs
//
//  Created by Steve Wight on 2/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "zThing.h"


@implementation zThing

@synthesize coords;
@synthesize sprite;

-(id)init
{
	
	return self;
}

- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	[sprite release];
	
	// don't forget to call "super dealloc"
	[super dealloc];
}


@end
