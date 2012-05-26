//
//  MenuScene.m
//  bounceZballs
//
//  Created by Steve Wight on 2/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#define kLastCompletedLevel @"lastCompletedLevel"

#import "MenuScene.h"
#import "AboutScene.h"
#import "LevelSelectScene.h"
#import "HowToScene.h"
#import "LevelSceneViewController.h"
#import "cocos2d.h"
#import "zCloud.h"
#import "SimpleAudioEngine.h"

@implementation MenuScene


+(id) scene
{
	CCScene *scene = [CCScene node];
	
	MenuScene *layer = [MenuScene node];
	
	[scene addChild:layer];
	
	return scene;
}


- (id) init
{
	self = [super init];
	if (self != nil) {
		
		CCSprite *bg = [CCSprite spriteWithFile:@"lightBlueBackground.png"];
		bg.position = ccp(240,160);
		[self addChild:bg z:0];
		
		[self generateGrassBackground];
		[self generateBall];
		
		CCSprite *header = [CCSprite spriteWithFile:@"mainMenuHeader.png"];
		header.position = ccp(240,270);
		[self addChild:header z:3];

		CCMenuItemImage *itemPlay = [CCMenuItemImage itemFromNormalImage:@"playMenuItem.png" selectedImage:@"playMenuItem_selected.png" 
																  target:self
																selector:@selector(onPlay:)];
		/*CCMenuItemImage *itemSettings = [CCMenuItemImage itemFromNormalImage:@"settingsMenuItem.png" selectedImage:@"settingsMenuItem_selected.png"
																	   target:self
																	 selector:@selector(onSettings:)];*/
		CCMenuItemImage *itemLevelSelect = [CCMenuItemImage itemFromNormalImage:@"selectLevelMenuItem.png" selectedImage:@"selectLevelMenuItem_selected.png"
																		  target:self
																		selector:@selector(onLevelSelect:)];
		CCMenuItemImage *itemAbout = [CCMenuItemImage itemFromNormalImage:@"aboutMenuItem.png" selectedImage:@"aboutMenuItem_selected.png"
																	target:self
																  selector:@selector(onAbout:)];
		CCMenuItemImage *itemHowTo = [CCMenuItemImage itemFromNormalImage:@"howToMenuItem.png" selectedImage:@"howToMenuItem_selected.png"
																	target:self
																  selector:@selector(onHowTo:)];
																				
		
		CCMenu *menu = [CCMenu menuWithItems:itemPlay, itemLevelSelect, itemHowTo, itemAbout, nil];
		menu.position = ccp(230,140);
		[menu alignItemsVerticallyWithPadding:2.5f];
		[self addChild:menu z:3];
		
		//Create cloud at start
		[self cloudLogic:1];
		
		[self schedule: @selector(cloudLogic:) interval:8.0];
		
	}
	return self;
}

- (void)onPlay:(id)sender
{
	
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	
	int levelNumber = 0;
	BOOL isTheLevelComplete;
	
	//check for the first level that is not complete
	do {
		levelNumber++;
		NSString *levelString = [NSString stringWithFormat:@"%i", levelNumber];
		isTheLevelComplete = [userDefaults boolForKey:levelString];
		
	} while (isTheLevelComplete && levelNumber<21);
	
	
	[[SimpleAudioEngine sharedEngine] playEffect:@"movinOn.caf"];
	
	LevelScene *scene = [[LevelScene alloc] initWithLevel:levelNumber];
	CCScene *newScene = (CCScene*) scene;
	[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:.5 scene:newScene]];
}

- (void)onAbout:(id)sender
{
	[[SimpleAudioEngine sharedEngine] playEffect:@"noteD.caf"];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:.5 scene:[AboutScene node]]];
}

- (void)onHowTo:(id)sender
{
	HowToScene *howToScene = [[HowToScene alloc] initWithScene:0];
	CCScene *newScene = (CCScene*)howToScene;
	
	[[SimpleAudioEngine sharedEngine] playEffect:@"noteE.caf"];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInT transitionWithDuration:.5 scene:newScene]];
}

- (void)onLevelSelect:(id)sender
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:.5 scene:[LevelSelectScene node]]];
	[[SimpleAudioEngine sharedEngine] playEffect:@"noteC.caf"];
}

-(void) addCloud:(zCloud*)cloud
{
	[self addChild:cloud.sprite z:cloud.zIndex];
	
	id actionMove = [CCMoveTo actionWithDuration:cloud.speedDuration 
										position:ccp(600,cloud.coords.y)];
	
	id actionMoveDone = [CCCallFuncN actionWithTarget:self 
											 selector:@selector(cloudMoveFinished:)];
	
	[cloud.sprite runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
}

-(void) cloudMoveFinished:(id)sender
{
	CCSprite *sprite = (CCSprite *)sender;
	[self removeChild:sprite cleanup:YES];
}

-(void)cloudLogic:(ccTime)dt
{
	zCloud *cloud = [[zCloud alloc] init];
	cloud.sprite.position = cloud.coords;
	[self addCloud:cloud];
	
	[cloud autorelease];
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

-(void) generateBall
{
	int rand = arc4random() % 480;
	zBall *theBall = [[zBall alloc] initWithCoords:ccp(rand,16)];
	[self addChild:theBall.sprite z:5];
	
	[theBall release];
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{	
	
	// don't forget to call "super dealloc"
	[super dealloc];
}



@end
