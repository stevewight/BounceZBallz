//
//  HelpScene.m
//  bounceZballs
//
//  Created by Steve Wight on 3/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HelpScene.h"
#import "AboutScene.h"
#import "SimpleAudioEngine.h"
#import "CCDirector.h"

@implementation HelpScene

+(id) scene
{
	CCScene *scene = [CCScene node];
	
	HelpScene *layer = [HelpScene node];
	
	[scene addChild:layer];
	
	return scene;
}

-(id) init
{
	if ((self = [super init])) {
		
		CCSprite *bg = [CCSprite spriteWithFile:@"lightBlueBackground.png"];
		bg.position = ccp(240,160);
		[self addChild:bg z:0];
		
		CCSprite *header = [CCSprite spriteWithFile:@"helpHeader.png"];
		header.position = ccp(240,270);
		[self addChild:header z:3];
		
		CCMenu *backMenu = [CCMenu menuWithItems:nil];
		CCMenuItemImage *item = [CCMenuItemImage itemFromNormalImage:@"backButton.png" 
													   selectedImage:@"backButton_selected.png"
															  target:self
															selector:@selector(onBackButton:)];
		[backMenu addChild:item];
		backMenu.position = ccp(45,262);
		[self addChild:backMenu];
		
		[self displayHelpList];
		[self displaySettings];
		
		[self generateGrassBackground];
	}
	return self;
}

-(void) displayHelpList
{
	int theX = 240;
	int theY = 220;
	
	for (int i=0; i<3; i++) {
		
		CCSprite *starPoint = [CCSprite spriteWithFile:@"star_12.png"];
		starPoint.position = ccp(theX-142,theY);
		[self addChild:starPoint z:4];
		
		NSString *theHelpString = [self pickItemWithNumberInList:i];
		CCLabelTTF *theHelpLabel = [[CCLabelTTF alloc] initWithString:theHelpString fontName:@"Arial" fontSize:16]; 
		theHelpLabel.position = ccp(theX,theY);
		theHelpLabel.color = ccc3(0, 0, 0);
		[self addChild:theHelpLabel z:2];
		
		theY = theY-27;
	}
}

-(NSString*) pickItemWithNumberInList:(int)numberInList
{
	NSString *itemInList;
	switch (numberInList) {
		case 0:
			itemInList = @"Remember to hit ALL the springs";
			break;
		case 1:
			itemInList = @"If a ball is in your way, tap on it";
			break;
		case 2:
			itemInList = @"In later levels, don't be affraid to roll";
			break;
		default:
			itemInList = @"Looks like a default";
			break;
	}
	return itemInList;
}

-(void) displaySettings
{
	NSString *theDotString = @"After 13 balls, a dot will mark the last start point";
	CCLabelTTF *theDotLabel = [[CCLabelTTF alloc] initWithString:theDotString fontName:@"Arial" fontSize:16]; 
	theDotLabel.position = ccp(240,131);
	theDotLabel.color = ccc3(0, 0, 0);
	[self addChild:theDotLabel z:2];
	
	CCSprite *dotPoint = [CCSprite spriteWithFile:@"lastBallDot.png"];
	dotPoint.position = ccp(62,131);
	[self addChild:dotPoint z:4];
	
	NSString *theHintString = @"After 31 balls, a hint will show the region to tap";
	CCLabelTTF *theHintLabel = [[CCLabelTTF alloc] initWithString:theHintString fontName:@"Arial" fontSize:16]; 
	theHintLabel.position = ccp(240,104);
	theHintLabel.color = ccc3(0, 0, 0);
	[self addChild:theHintLabel z:2];
	
	CCSprite *starPoint = [CCSprite spriteWithFile:@"lastBallDot.png"];
	starPoint.position = ccp(62,104);
	[self addChild:starPoint z:4];
	
}

-(void) onBackButton:(id)sender
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInL transitionWithDuration:.5 scene:[AboutScene node]]];
	[[SimpleAudioEngine sharedEngine] playEffect:@"noteD.caf"];
}

-(void) generateGrassBackground
{
	CCSprite *grass = [CCSprite spriteWithFile:@"grass_long.png"];
	grass.position = ccp(240,10);
	[self addChild:grass z:1];
	
	//Create the random grass sprites and place them
	for (int i=1; i<6; i++) {
		CCSprite *grassImage;
		NSString *spriteFileName;
		
		//randomly select a sprite file name
		switch (arc4random() % 5) {
			case 0:
				spriteFileName = @"grass_1.png";
				break;
			case 1:
				spriteFileName = @"grass_2.png";
				break;
			case 2:
				spriteFileName = @"grass_3.png";
				break;
			case 3:
				spriteFileName = @"grass_4.png";
				break;
			case 4:
				spriteFileName = @"grass_5.png";
				break;
			default:
				spriteFileName = @"grass_1.png";
				break;
		}
		
		
		int rand = arc4random() % 480;
		grassImage = [CCSprite spriteWithFile:spriteFileName];
		grassImage.position = ccp(rand,10);
		
		[self addChild:grassImage z:8];
	}
}


- (void) dealloc
{
	
	// don't forget to call "super dealloc"
	[super dealloc];
}



@end
