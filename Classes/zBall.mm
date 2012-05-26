//
//  zBall.m
//  bounceZballs
//
//  Created by Steve Wight on 2/5/11.
//  Copyright 2011 __ZiatoGroup__. All rights reserved.
//
#define PTM_RATIO 32

#import "zBall.h"
#import "zSpring.h"


@implementation zBall

@synthesize contactSprings;
@synthesize lastSpringHit;
@synthesize repeatSpringHit;

-(id)initWithCoords:(CGPoint)p
{
	if((self = [super init]))
	{
		
	self.contactSprings = [[NSMutableSet alloc] init];
	self.repeatSpringHit = 0;
		
	self.sprite = [CCSprite spriteWithFile:@"ball.png"];
	self.sprite.position = ccp(p.x, p.y);
	self.sprite.tag = 1;
	self.sprite.userData = self;
	
	self.coords = p;
	
	}
	
	return self;
}

-(void) addContactSpring:(zSpring*)contactSpring
{
	[self.contactSprings addObject:contactSpring];
}

- (void) dealloc
{	
	[contactSprings release];
	[lastSpringHit release];
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
