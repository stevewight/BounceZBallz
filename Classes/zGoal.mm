//
//  zGoal.m
//  bounceZballs
//
//  Created by Steve Wight on 2/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "zGoal.h"


@implementation zGoal

-(id)initWithCoords:(CGPoint)p
{
	self.sprite = [CCSprite spriteWithFile:@"goalBall.png"];
	
	self.sprite.position = ccp(p.x, p.y);
	self.sprite.tag = 4;
	self.sprite.userData = self;
	
	self.coords = p;
	
	return self;
}

- (void) dealloc
{
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
