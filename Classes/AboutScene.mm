//
//  AboutScene.m
//  bounceZballs
//
//  Created by Steve Wight on 2/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AboutScene.h"
#import "cocos2d.h"
#import "MenuScene.h"
#import "zCloud.h"
#import "SimpleAudioEngine.h"
#import "HelpScene.h"

@implementation AboutScene

+(id) scene
{
	CCScene *scene = [CCScene node];
	
	AboutScene *layer = [AboutScene node];
	
	[scene addChild:layer];
	
	//[self schedule:@selector(onEnd:) interval:5];
	
	return scene;
}

-(id) init
{
	if ((self = [super init])) {
		
		CCSprite *bg = [CCSprite spriteWithFile:@"lightBlueBackground.png"];
		bg.position = ccp(240,160);
		[self addChild:bg z:0];
		
		CCSprite *header = [CCSprite spriteWithFile:@"aboutHeader.png"];
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
		
		CCMenu *helpMenu = [CCMenu menuWithItems:nil];
		CCMenuItemImage *helpItem = [CCMenuItemImage itemFromNormalImage:@"helpButton.png"
														   selectedImage:@"helpButton_selected.png"
																  target:self
																selector:@selector(onHelpButton:)];
		
		[helpMenu addChild:helpItem];
		helpMenu.position = ccp(435,262);
		[self addChild:helpMenu];
		
		NSString *devBy = @"Developed By: ";
		CCLabelBMFont *devByLabel = [CCLabelBMFont labelWithString:devBy fntFile:@"ErasMediumBlue.fnt"]; 
		devByLabel.position = ccp(159,191);
		[self addChild:devByLabel z:2];
		
		NSString *sw = @"Steve Wight";
		CCLabelBMFont *swLabel = [CCLabelBMFont labelWithString:sw fntFile:@"ErasDemiRed.fnt"]; 
		swLabel.position = ccp(323,191);
		[self addChild:swLabel z:2];
		
		NSString *at = @"@";
		CCLabelBMFont *atLabel = [CCLabelBMFont labelWithString:at fntFile:@"ErasBoldRed.fnt"]; 
		atLabel.position = ccp(240,147);
		[self addChild:atLabel z:2];
		
		NSString *zGroup = @"www.ZiatoGroup.com";
		CCLabelBMFont *zLabel = [CCLabelBMFont labelWithString:zGroup fntFile:@"ErasMediumBlue.fnt"]; 
		zLabel.position = ccp(240,107);
		[self addChild:zLabel z:2];
		
		
		[self generateGrassBackground];
		
		//Create cloud at start
		[self cloudLogic:1];
		
		[self schedule: @selector(cloudLogic:) interval:8.0];
		
	}
	return self;
}

-(void) onBackButton:(id)sender
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInL transitionWithDuration:.5 scene:[MenuScene node]]];
	[[SimpleAudioEngine sharedEngine] playEffect:@"noteG.caf"];
}

-(void) onHelpButton:(id)sender
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:.5 scene:[HelpScene node]]];
	[[SimpleAudioEngine sharedEngine] playEffect:@"noteB.caf"];
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
