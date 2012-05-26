//
//  zSpring.m
//  bounceZballs
//
//  Created by Steve Wight on 2/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#define PTM_RATIO 32

#import "zSpring.h"


@implementation zSpring

@synthesize springType;
@synthesize spriteFileName;

-(id)initWithCoords:(CGPoint)p withSpringType:(int)st
{
	self.springType = st;
	
	self.sprite = [[CCSprite alloc] initWithFile:[self loadImageFileName]];
	[sprite setAnchorPoint:ccp(0.0,0.0)];
	
	self.sprite.position = ccp(p.x, p.y);
	self.sprite.tag = 2;
	self.sprite.userData = self;
	
	self.coords = p;
	self.sprite = sprite;
	
	return self;
}

-(NSString*) loadImageFileName
{	
	/*
	NSString *fileName;
	switch (self.springType) {
		case 0:
			fileName = @"spring_0.png";
			break;
		case 1:
			fileName = @"spring_1.png";
			break;
		case 2:
			fileName = @"spring_2.png";
			break;
		case 3:
			fileName = @"spring_3.png";
			break;
		case 4:
			fileName = @"spring_4.png";
			break;
		case 5:
			fileName = @"spring_5.png";
			break;
		case 6:
			fileName = @"spring_6.png";
			break;
		case 7:
			fileName = @"spring_7.png";
			break;
		case 8:
			fileName = @"spring_8.png";
			break;
		case 9:
			fileName = @"spring_9.png";
			break;
		case 10:
			fileName = @"spring_10.png";
			break;
		case 11:
			fileName = @"spring_11.png";
			break;
		default:
			fileName = @"smallBall.png";
			break;
	}
	*/
	NSString *typeString = [NSString stringWithFormat:@"%i", self.springType];
	NSString *startString = @"spring_";
	NSString *midString = [startString stringByAppendingString:typeString];
	NSString *fileName = [midString stringByAppendingString:@".png"];
	
	return fileName;
}

- (void) dealloc
{
	[spriteFileName release];
	[sprite release];
	
	// don't forget to call "super dealloc"
	[super dealloc];
}


@end
