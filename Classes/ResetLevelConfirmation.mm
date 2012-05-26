//
//  ResetLevelConfirmation.m
//  bounceZballs
//
//  Created by Steve Wight on 3/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ResetLevelConfirmation.h"
#import "cocos2d.h"
#import "GameComplete.h"
#import "SimpleAudioEngine.h"


@implementation ResetLevelConfirmation

@synthesize isFromWinScene;

+(id) scene
{
	CCScene *scene = [CCScene node];
	
	ResetLevelConfirmation *layer = [ResetLevelConfirmation node];
	
	[scene addChild:layer];
	
	return scene;
}

-(id) initWithIsWinScene:(BOOL)isWinScene
{
	if ((self = [super init])) {
		
		self.isFromWinScene = isWinScene;
		
	//Create the background and add it to the scene
	CCSprite *bg = [CCSprite spriteWithFile:@"lightBlueBackground.png"];
	bg.position = ccp(240,160);
	[self addChild:bg z:0];
	
	CCLabelBMFont *commentLabel = [CCLabelBMFont labelWithString:@"Do you want to reset all the levels?" fntFile:@"ErasDemiRed.fnt"]; 
	commentLabel.position = ccp(240,241);
	[self addChild:commentLabel z:2];
		
		NSString *noteString = @"NOTE: All level completions and top scores will be erased.";
		CCLabelTTF *noteLabel = [[CCLabelTTF alloc] initWithString:noteString fontName:@"Arial" fontSize:16];
		noteLabel.position = ccp(240,131);
		noteLabel.color = ccc3(0,0,0);
		[self addChild:noteLabel];
		[noteString autorelease];
	[self displayMenu];
		
	}
	
	return self;
}

-(void) displayMenu
{
	
	CCMenuItemImage *itemYes = [CCMenuItemImage itemFromNormalImage:@"yesMenuItem.png"
													  selectedImage:@"yesMenuItem_selected.png"
															 target:self
														   selector:@selector(onYes:)];
	CCMenuItemImage *itemNo = [CCMenuItemImage itemFromNormalImage:@"noMenuItem.png"
													 selectedImage:@"noMenuItem_selected.png"
															target:self
														  selector:@selector(onNo:)];
	CCMenu *menu = [CCMenu menuWithItems:itemYes, itemNo, nil];
	
	menu.position = ccp(240,31);
	[menu alignItemsHorizontallyWithPadding:3.5];
	[self addChild:menu z:3];
}

-(void) onYes:(id)sender
{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	NSString *scoreString = @"levelScore";
	NSString *levelStarString = @"star";
	
	for (int i=1; i<22; i++) {
		NSString *resetLevelString = [NSString stringWithFormat:@"%i", i];
		[userDefaults setBool:0 forKey:resetLevelString];
		
		NSString *finalString = [scoreString stringByAppendingString:resetLevelString];
		[userDefaults setInteger:0 forKey:finalString];
		
		NSString *levelStarKey = [levelStarString stringByAppendingString:resetLevelString];
		[userDefaults setInteger:0 forKey:levelStarKey];
	}
	
	[userDefaults synchronize];
	[scoreString release];
	
	GameComplete *gameCompleteScene = [[GameComplete alloc] initWithMeasure:self.isFromWinScene];
	CCScene *newScene = (CCScene*)gameCompleteScene;
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFadeDown transitionWithDuration:.3 scene:newScene]];
	[[SimpleAudioEngine sharedEngine] playEffect:@"noteC8th.caf"];
}

-(void) onNo:(id)sender
{
	GameComplete *gameCompleteScene = [[GameComplete alloc] initWithMeasure:self.isFromWinScene];
	CCScene *newScene = (CCScene*)gameCompleteScene;
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFadeDown transitionWithDuration:.3 scene:newScene]];
	[[SimpleAudioEngine sharedEngine] playEffect:@"noteF.caf"];
}

- (void) dealloc
{
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
