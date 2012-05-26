//
//  zBlock.m
//  bounceZballs
//
//  Created by Steve Wight on 2/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#define PTM_RATIO 32

#import "zBlock.h"


@implementation zBlock

@synthesize blockType;

-(id)initWithCoords:(CGPoint)p blockType:(int)bt
{
	if((self = [super init])){
	
	//int32 count = 4;
	
	self.blockType = bt;
	
	self.sprite = [[CCSprite alloc] initWithFile:[self loadSpriteFileString]];
	
	sprite.position = ccp(p.x, p.y);
	sprite.tag = 3;
	self.sprite.userData = self;
	
	self.coords = p;
	self.sprite = sprite;
		
	}
	
	
	return self;
}

-(NSString*) loadSpriteFileString
{
	NSString *spriteFileName;
	switch (blockType) {
		case 0:
			spriteFileName = @"purpleBox_32x32.png";
			break;
		case 1:
			spriteFileName = @"purpleBox_64x7.png";
			break;
		case 2:
			spriteFileName = @"purpleBox_7x64.png";
			break;
		default:
			spriteFileName = @"purpleBox_32x32.png";
			break;
	}
	return spriteFileName;
}


- (void) dealloc
{
	[sprite release];
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
