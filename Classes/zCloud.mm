//
//  zCloud.m
//  bounceZballs
//
//  Created by Steve Wight on 2/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "zCloud.h"


@implementation zCloud

@synthesize speedDuration;
@synthesize zIndex;

-(id)init
{	
	self.sprite = [CCSprite spriteWithFile:[self loadCloudFileName]];
			
	[self loadCloudPosition];
	
	[self loadSpeedDuration];
	
	[self loadCloudZIndex];
	
	return self;
}

-(NSString*) loadCloudFileName
{
	
	//randomly generate one of the cloud sprites 
	NSString *fileName;
	switch ((arc4random() % 7)) {
		case 0:
			fileName = @"blurCloud_1.png";
			break;
		case 1:
			fileName = @"blurCloud_2.png";
			break;
		case 2:
			fileName = @"blurCloud_3.png";
			break;
		case 3:
			fileName = @"blurCloud_4.png";
			break;
		case 4:
			fileName = @"blurCloud_5.png";
			break;
		case 5:
			fileName = @"blurCloud_6.png";
			break;
		case 6:
			fileName = @"blurCloud_7.png";
			break;
		default:
			fileName = @"blurCloud_1.png";
			break;
	}
	
	return fileName;

}

-(void) loadSpeedDuration
{
	//Determine the speed of the target
	int minDuration = 61.0;
	int maxDuration = 91.0;
	int rangeDuration = maxDuration - minDuration;
	
	self.speedDuration = (arc4random() % rangeDuration) + minDuration;
}

-(void) loadCloudZIndex
{
	int rand = (arc4random() % 10);
	if (rand<7) {
		self.zIndex = 1;
	}
	else {
		self.zIndex = 8;
	}
}

-(void) loadCloudPosition
{
	//randomly select where on the y axis the cloud will be displayed
	int posMax = 240;
	int posMin = 113;
	int rand = (arc4random() % posMax) + posMin;
	
	self.coords = ccp(-50,rand);
}

- (void) dealloc
{
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
