//
//  zTutorial.m
//  bounceZballs
//
//  Created by Steve Wight on 3/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "zTutorial.h"
#import "cocos2d.h"


@implementation zTutorial
	
@synthesize tutorialLevel;
@synthesize hints;

-(id) initWithLevel:(int)tutLevel
{
	self.tutorialLevel = tutLevel;
	self.hints = [[NSMutableArray alloc] initWithArray:nil];
	
	return self;
}

-(NSMutableArray*) getTutorialHints
{
	
	if (self.tutorialLevel==1) {
		CCSprite *hintSprite = [[CCSprite alloc] initWithFile:@"level1Hint_1.png"];
		hintSprite.position = ccp(175,131);
		[hints addObject:hintSprite];
		
	} else if (self.tutorialLevel==2) {
		
		CCSprite *hintSprite = [[CCSprite alloc] initWithFile:@"level2Hint_1.png"];
		hintSprite.position = ccp(67,185);
		[hints addObject:hintSprite];
		
		CCSprite *hintSpriteTwo = [[CCSprite alloc] initWithFile:@"level2Hint_2.png"];
		hintSpriteTwo.position = ccp(413,185);
		[hints addObject:hintSpriteTwo];
		
		
	} else if (self.tutorialLevel == 3) {
		
		CCSprite *hintSprite = [[CCSprite alloc] initWithFile:@"level3Hint_1.png"];
		hintSprite.position = ccp(175,221);
		[hints addObject:hintSprite];
		
		CCSprite *hintSpriteTwo = [[CCSprite alloc] initWithFile:@"level3Hint_2.png"];
		hintSpriteTwo.position = ccp(31,131);
		[hints addObject:hintSpriteTwo];
		
		CCSprite *hintSpriteThree = [[CCSprite alloc] initWithFile:@"level3Hint_3.png"];
		hintSpriteThree.position = ccp(375,250);
		[hints addObject:hintSpriteThree];
		
		CCSprite *hintSpriteFour = [[CCSprite alloc] initWithFile:@"level3Hint_4.png"];
		hintSpriteFour.position = ccp(360,131);
		[hints addObject:hintSpriteFour];
		
		
	} else if (self.tutorialLevel == 4) {
		
		CCSprite *hintSprite = [[CCSprite alloc] initWithFile:@"level4Hint_1.png"];
		hintSprite.position = ccp(240,213);
		[hints addObject:hintSprite];
		
	}else {

		CCSprite *hintSprite = [[CCSprite alloc] initWithFile:@"star_12.png"];
		hintSprite.position = ccp(240,31);
		[hints addObject:hintSprite];
	}
	
	return self.hints;
}

@end
