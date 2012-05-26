//
//  LevelSelectScene.m
//  bounceZballs
//
//  Created by Steve Wight on 2/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LevelSelectScene.h"
#import "cocos2d.h"
#import "MenuScene.h"
#import "LevelSceneViewController.h"
#import "zCloud.h"
#import "GameComplete.h"
#import "SimpleAudioEngine.h"

@implementation LevelSelectScene

+(id) scene
{
	CCScene *scene = [CCScene node];
	
	LevelSelectScene *layer = [LevelSelectScene node];
	
	[scene addChild:layer];
	
	return scene;
}

-(id) init
{
	if ((self = [super init])) {
		
	CCSprite *bg = [CCSprite spriteWithFile:@"lightBlueBackground.png"];
	bg.position = ccp(240,160);
	[self addChild:bg z:0];
		
	CCSprite *header = [CCSprite spriteWithFile:@"levelSelectHeader.png"];
	header.position = ccp(240,270);
	[self addChild:header z:3];
	
		CCMenu *backMenu = [CCMenu menuWithItems:nil];
		CCMenuItemImage *item = [CCMenuItemImage itemFromNormalImage:@"menuBackButton.png" 
														selectedImage:@"menuBackButton_selected.png"
															   target:self
															 selector:@selector(onBackButton:)];
		[backMenu addChild:item];
		backMenu.position = ccp(45,262);
		[self addChild:backMenu];
		
		CCMenu *checkMenu = [CCMenu menuWithItems:nil];
		CCMenuItemImage *checkItem = [CCMenuItemImage itemFromNormalImage:@"checkButton.png" 
															selectedImage:@"checkButton_selected.png"
																   target:self
																 selector:@selector(onCheckButton:)];
		
		[checkMenu addChild:checkItem];
		checkMenu.position = ccp(431,262);
		[self addChild:checkMenu];
		
		//Create cloud at start
		[self cloudLogic:1];
		
		[self createLevelSelectMenu];
		
		[self generateGrassBackground];
		
		[self schedule: @selector(cloudLogic:) interval:8.0];
	}
	return self;
}



-(void) createLevelSelectMenu
{	
	int count = 22;
	
	CCMenu *menu = [CCMenu menuWithItems:nil];
	CCMenu *menuTwo = [CCMenu menuWithItems:nil];
	CCMenu *menuThree = [CCMenu menuWithItems:nil];
	
	for (int i=1; i<count; i++) {
		NSString *preString = @"levelButton";
		NSString *countString = [NSString stringWithFormat:@"%d",i];
		NSString *midString = [preString stringByAppendingString:countString];
		NSString *postString = @".png";
		NSString *postStringSelected = @"_selected.png";
		NSString *normalImage = [midString stringByAppendingString:postString];
		NSString *selectedImage = [midString stringByAppendingString:postStringSelected];

		CCMenuItemImage *item = [CCMenuItemImage itemFromNormalImage:normalImage 
														selectedImage:selectedImage
															   target:self
																selector:@selector(onLevel:)];
		
		item.userData = (id)i;
		
		if (i<8) {
			[menu addChild:item];
		}
		else if(i<15)
		{
			[menuTwo addChild:item];
		}
		else if(i<22)
		{
			[menuThree addChild:item];
		}
								 
	}
	
	menu.position = ccp(240,198);
	[menu alignItemsHorizontallyWithPadding:10.1f];
	
	menuTwo.position = ccp(240,122);
	[menuTwo alignItemsHorizontallyWithPadding:10.1f];
	
	menuThree.position = ccp(240,46);
	[menuThree alignItemsHorizontallyWithPadding:10.1f];
	
	[self addChild:menu z:3];
	[self addChild:menuTwo z:3];
	[self addChild:menuThree z:3];
}

-(void) onLevel:(id)sender
{
	CCMenuItemImage *item = sender;
	NSNumber *levelFromItem = (NSNumber*)item.userData;
	LevelScene *scene = [[LevelScene alloc] initWithLevel:(int)levelFromItem];
	CCScene *newLayer = (CCScene*) scene;
	
	[[SimpleAudioEngine sharedEngine] playEffect:@"movinOn.caf"];
	
	[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInL transitionWithDuration:.5 scene:newLayer]];
}

-(void) onBackButton:(id)sender
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInL transitionWithDuration:.5 scene:[MenuScene node]]];
	[[SimpleAudioEngine sharedEngine] playEffect:@"noteG.caf"];
}

-(void) onCheckButton:(id)sender
{
	CCScene *newScene;
	GameComplete *scene = [[GameComplete alloc] initWithMeasure:NO];
	newScene = (CCScene*)scene;

	[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:.5 scene:newScene]];
	[[SimpleAudioEngine sharedEngine] playEffect:@"noteF.caf"];
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

- (void) dealloc
{
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
