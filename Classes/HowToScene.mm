//
//  HowToScene.m
//  bounceZballs
//
//  Created by Steve Wight on 2/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HowToScene.h"
#import "cocos2d.h"
#import "MenuScene.h"
#import "SimpleAudioEngine.h"


@implementation HowToScene

@synthesize sceneNumber;
@synthesize headerImage;
@synthesize sceneImage;
@synthesize explanationLabel;

+(id) scene
{
	CCScene *scene = [CCScene node];
	
	HowToScene *layer = [HowToScene node];
	
	[scene addChild:layer];
	
	return scene;
}

-(id) initWithScene:(int)scene
{
	if ((self = [super init])) {
		
	self.sceneNumber = scene;
		
	//Load the background
	CCSprite *bg = [CCSprite spriteWithFile:@"lightBlueBackground.png"];
	bg.position = ccp(240,160);
	[self addChild:bg];
	
		
	[self loadSceneInfo];
		
	[self loadMenuButton];
		
	}
	return self;
}

-(void)loadSceneInfo
{
	NSString *explanationLabelString;
	NSString *headerFileString;
	NSString *sceneFileString;
		switch (self.sceneNumber) {
			case 0:
				explanationLabelString = @"Tap above Spring to drop Ball";
				headerFileString = @"howToPlayHeader.png";
				sceneFileString = @"howToPlay.png";
				break;
			case 1:
				explanationLabelString = @"Ball must hit the Goal to complete level";
				headerFileString = @"howToWinHeader.png";
				sceneFileString = @"howToWin.png";
				break;
			case 2:
				explanationLabelString = @"Ball doesn't hit all springs, your a cheater";
				headerFileString = @"howToCheatHeader.png";
				sceneFileString = @"howToCheat.png";
				break;
			case 3:
				explanationLabelString = @"Hit the blocks and your ball blows up";
				headerFileString = @"howToBlowUpHeader.png";
				sceneFileString = @"howToBlowUp.png";
				break;
			case 4:
				explanationLabelString = @"";
				headerFileString = @"howToMasterHeader.png";
				sceneFileString = @"howToMaster.png";
				break;
			default:
				break;
		}
	
	headerImage = [[CCSprite alloc] initWithFile:headerFileString];
	[self addChild:headerImage z:1];
	headerImage.position = ccp(240,270);
	
	sceneImage = [[CCSprite alloc] initWithFile:sceneFileString];
	[self addChild:sceneImage z:1];
	sceneImage.position = ccp(240,145);
	
	explanationLabel = [CCLabelTTF labelWithString:explanationLabelString fontName:@"Arial" fontSize:21];
	[self addChild:explanationLabel z:0];
	[explanationLabel setColor:ccc3(0,0,0)];
	explanationLabel.position = ccp(240,220);
}

-(void)loadMenuButton
{
	CCMenu *menu = [CCMenu menuWithItems:nil];
	CCMenuItemImage *menuItem;
	
	if (self.sceneNumber!=4) {
		menuItem = [CCMenuItemImage itemFromNormalImage:@"nextMenuItem.png" 
										  selectedImage:@"nextMenuItem_selected.png"
												 target:self
											   selector:@selector(onNext:)];
	} else {
		menuItem = [CCMenuItemImage itemFromNormalImage:@"mainMenuItem.png"
										  selectedImage:@"mainMenuItem_selected.png"
												 target:self
											   selector:@selector(onMainMenu:)];
	}
	
	[menu addChild:menuItem];
	menu.position = ccp(240,40);
	[self addChild:menu];

}

-(void)onNext:(id)sender
{
	[self playButtonSound];
	int nextScene = self.sceneNumber+1;
	HowToScene *scene = [[HowToScene alloc] initWithScene:nextScene];
	CCScene *newScene = (CCScene*)scene;
	[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:.5 scene:newScene]];
}

-(void) playButtonSound
{
	NSString *fileName;
	
	switch (self.sceneNumber) {
		case 0:
			fileName = @"noteF.caf";
			break;
		case 1:
			fileName = @"noteG.caf";
			break;
		case 2:
			fileName = @"noteA.caf";
			break;
		case 3:
			fileName = @"noteB.caf";
			break;
		case 4:
			fileName = @"noteC8th.caf";
		default:
			fileName = @"noteC8th";
			break;
	}
	
	[[SimpleAudioEngine sharedEngine] playEffect:fileName];
}


-(void)onMainMenu:(id)sender
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInB transitionWithDuration:.5 scene:[MenuScene node]]];
	[[SimpleAudioEngine sharedEngine] playEffect:@"noteC8th.caf"];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	[headerImage release];
	[sceneImage release];
	[explanationLabel release];
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
