//
//  GameComplete.m
//  bounceZballs
//
//  Created by Steve Wight on 2/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameComplete.h"
#import "LevelSummaryScene.h"
#import "cocos2d.h"
#import "MenuScene.h"
#import "LevelSelectScene.h"
#import "ResetLevelConfirmation.h"
#import "SimpleAudioEngine.h"


@implementation GameComplete

@synthesize theTotalScore;
@synthesize isTheWinScreen;

+(id) scene
{
	CCScene *scene = [CCScene node];
	
	GameComplete *layer = [GameComplete node];
	
	[scene addChild:layer];
	
	return scene;
}

-(id) initWithMeasure:(BOOL)isWinScreen
{
	if ((self = [super init])) {
		
		self.isTheWinScreen = isWinScreen;
		
	//Create the background and add it to the scene
	CCSprite *bg = [CCSprite spriteWithFile:@"lightBlueBackground.png"];
	bg.position = ccp(240,160);
	[self addChild:bg z:0];
	
	if ([self areAllLevelsComplete] && isWinScreen) {
		NSString *congratsString = @"Congrat's Champ, You did it!";
		CCLabelBMFont *congratsLabel = [CCLabelBMFont labelWithString:congratsString fntFile:@"ErasDemiRed.fnt"]; 
		congratsLabel.position = ccp(240,285);
		[self addChild:congratsLabel z:2];
		
		//display the total score
		[self displayTotalScore];
		
		[self pickFinalStatment:theTotalScore];
		
	} else if ([self areAllLevelsComplete] && !isWinScreen) {
		NSString *congratsString = @"Levels are Complete";
		
		CCLabelBMFont *congratsLabel = [CCLabelBMFont labelWithString:congratsString fntFile:@"ErasDemiRed.fnt"]; 
		congratsLabel.position = ccp(240,300);
		[self addChild:congratsLabel z:2];
		
		//display what levels are complete
		[self displayLevelsStatus];
	} else {
		NSString *congratsString = @"Some Levels Not Complete";
		
		CCLabelBMFont *congratsLabel = [CCLabelBMFont labelWithString:congratsString fntFile:@"ErasDemiRed.fnt"]; 
		congratsLabel.position = ccp(240,300);
		[self addChild:congratsLabel z:2];
		
		//display what levels are complete
		[self displayLevelsStatus];
	}

	 
	
	[self displayMenuWithSuccess:[self areAllLevelsComplete]];
	
		
	}
	return self;
}



-(void) backToMenu
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:.5 scene:[MenuScene node]]];
	[[SimpleAudioEngine sharedEngine] playEffect:@"noteG.caf"];
}

-(void) onMainMenu:(id)sender
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:.5 scene:[MenuScene node]]];
	[[SimpleAudioEngine sharedEngine] playEffect:@"noteG.caf"];
}

-(void) onSelectLevel:(id)sender
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInL transitionWithDuration:.5 scene:[LevelSelectScene node]]];
	[[SimpleAudioEngine sharedEngine] playEffect:@"noteC.caf"];
}

-(void) displayMenuWithSuccess:(BOOL)isSuccess
{
	CCMenu *menu = [CCMenu menuWithItems:nil];
	
	CCMenuItemImage *itemMainMenu = [CCMenuItemImage itemFromNormalImage:@"mainMenuItem.png" selectedImage:@"mainMenuItem_selected.png"
																  target:self
																selector:@selector(onMainMenu:)];
	CCMenuItemImage *itemLevelSelect = [CCMenuItemImage itemFromNormalImage:@"selectLevelMenuItem.png" selectedImage:@"selectLevelMenuItem_selected.png"
																	 target:self
																selector:@selector(onSelectLevel:)];
	CCMenuItemImage *itemResetLevels = [CCMenuItemImage itemFromNormalImage:@"resetLevelsMenuItem.png"
															  selectedImage:@"resetLevelsMenuItem_selected.png"
																	 target:self
																   selector:@selector(onResetLevels:)];
	
	
	if (isSuccess) {
		
		[menu addChild:itemMainMenu];
	} else {
		[menu addChild:itemLevelSelect];
	}

	[menu addChild:itemResetLevels];
	
	
	menu.position = ccp(240,31);
	[menu alignItemsHorizontallyWithPadding:3.5];
	[self addChild:menu];

}

-(BOOL) areAllLevelsComplete
{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	
	BOOL allLevelsComplete = YES;
	
	for (int i=1; i<22; i++) {
		NSString *levelString = [NSString stringWithFormat:@"%i", i];
		if (![userDefaults boolForKey:levelString]) {
			allLevelsComplete = NO;
		}
	}
	
	return allLevelsComplete;
}

-(void) displayLevelsStatus
{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	
	int y = 260;
	int x = 21;
	for (int i=1; i<22; i++) {
		
		NSString *levelString = [NSString stringWithFormat:@"%i", i];
		
		BOOL isLevelComplete = [userDefaults boolForKey:levelString];
		
		if (isLevelComplete) {
			
			NSString *levelStarString = @"star";
			NSString *levelStarKey = [levelStarString stringByAppendingString:levelString];
			NSInteger numberOfStars = [userDefaults integerForKey:levelStarKey];
			[self displaySmallStarWithAmount:numberOfStars atCoords:ccp(x+26,y)];
			
		} else {
			
			[self displaySmallStarWithAmount:0 atCoords:ccp(x+26,y)];
		}
		
		NSString *finalString = [levelString stringByAppendingString:@"}"];
		
		
		CCLabelBMFont *levelLabel = [CCLabelBMFont labelWithString:finalString fntFile:@"ErasMediumBlue.fnt"]; 
		levelLabel.position = ccp(x,y);
		[self addChild:levelLabel z:2];
		
		if (i==7) {
			x = x + 161;
			y = 291;
		} else if (i==14) {
			x= x + 161;
			y = 291;
		} 
		
		y = y-31;
		 
	}
	
}

-(void) pickFinalStatment:(int)finalScore
{
	NSString *finalStatment;
	int amountOfStars = 1;
	
	if (finalScore > 1990000) {
		finalStatment = @"You are a Master! The best of the best!";
		amountOfStars = 7;
	} else if (finalScore > 1950000) {
		finalStatment = @"Amazing! You are almost a Master!";
		amountOfStars = 6;
	} else if (finalScore > 1900000) {
		finalStatment = @"Awesome! You are an All-Star!";
		amountOfStars = 6;
	} else if (finalScore > 1850000) {
		finalStatment = @"You are really good at this game!";
		amountOfStars = 6;
	} else if (finalScore > 1800000) {
		finalStatment = @"Your skills are impressive.";
		amountOfStars = 5;
	} else if (finalScore > 1750000) {
		finalStatment = @"You have surpassed expectations ";
		amountOfStars = 5;
	} else if (finalScore > 1700000) {
		finalStatment = @"You are better then average";
		amountOfStars = 4;
	} else if (finalScore > 1650000) {
		finalStatment = @"Keep up the good work";
		amountOfStars = 3;
	} else if (finalScore > 1600000) {
		finalStatment = @"Starting to get good at this";
		amountOfStars = 3;
	} else if (finalScore > 1500000) {
		finalStatment = @"Starting to get it";
		amountOfStars = 2;
	} else if (finalScore > 1400000) {
		finalStatment = @"Play some of the levels again";
		amountOfStars = 2;
	} else if (finalScore > 1300000) {
		finalStatment = @"You might want to try again";
	} else {
		finalStatment = @"Well you finished the game but... ";
	}
	
	CCLabelBMFont *finalStatmentLabel = [CCLabelBMFont labelWithString:finalStatment fntFile:@"ErasMediumBlue.fnt"]; 
	finalStatmentLabel.position = ccp(240,160);
	[self addChild:finalStatmentLabel z:2];
	
	[self displayStarsWithAmount:amountOfStars];
}

-(void) displayTotalScore
{
	NSInteger totalScore = 0;
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	
	for (int i=1; i<22; i++) {
		NSString *levelString = [NSString stringWithFormat:@"%i", i];
		NSString *levelScoreString = @"levelScore";
		NSString *levelScoreKey = [levelScoreString stringByAppendingString:levelString];
		
		NSInteger theLevelScore = [userDefaults integerForKey:levelScoreKey];
		totalScore = totalScore + theLevelScore;
	}
	theTotalScore = totalScore;
	
	NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
	[numFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
	NSNumber *totalScoreNumber = [NSNumber numberWithInt:totalScore];
	NSString *formattedTotalScore = [numFormatter stringFromNumber:totalScoreNumber];
	
	CCLabelBMFont *totalLabel = [CCLabelBMFont labelWithString:@"Total Score:" fntFile:@"ErasMediumBlue.fnt"]; 
	totalLabel.position = ccp(240,240);
	[self addChild:totalLabel z:2];
	
	
	CCLabelBMFont *totalScoreLabel = [CCLabelBMFont labelWithString:formattedTotalScore fntFile:@"ErasDemiRed.fnt"]; 
	totalScoreLabel.position = ccp(240,207);
	[self addChild:totalScoreLabel z:2];
	
	[numFormatter autorelease];
	
}

-(void) onResetLevels:(id)sender
{
	
	ResetLevelConfirmation *resetConfirmation = [[ResetLevelConfirmation alloc] initWithIsWinScene:self.isTheWinScreen];
	CCScene *newScene = (CCScene*) resetConfirmation;
	
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFadeDown transitionWithDuration:.3 scene:newScene]];
	[[SimpleAudioEngine sharedEngine] playEffect:@"noteA.caf"];
}

-(void)displayStarsWithAmount:(int)amountOfStars
{
	int starX = 65;
	int starY = 100;
	
	for (int i=0; i<amountOfStars; i++) {
		CCSprite *starToDisplay = [CCSprite spriteWithFile:@"star.png"];
		starToDisplay.position = ccp(starX,starY);
		[self addChild:starToDisplay];
		starX = starX + 57;
	}
	
	for (int i=0; i<7-amountOfStars; i++) {
		CCSprite *starToDisplay = [CCSprite spriteWithFile:@"star_disabled.png"];
		starToDisplay.position = ccp(starX,starY);
		[self addChild:starToDisplay];
		starX = starX + 57;
	}
}

-(void) displaySmallStarWithAmount:(int)amountOfStars atCoords:(CGPoint)coords
{
	int starX = coords.x;
	int starY = coords.y;
	
	for (int i=0; i<amountOfStars; i++) {
		CCSprite *starToDisplay = [CCSprite spriteWithFile:@"star_16.png"];
		starToDisplay.position = ccp(starX,starY);
		[self addChild:starToDisplay];
		starX = starX + 16;
	}
	
	for (int i=0; i<7-amountOfStars; i++) {
		CCSprite *starToDisplay = [CCSprite spriteWithFile:@"star_16_disabled.png"];
		starToDisplay.position = ccp(starX,starY);
		[self addChild:starToDisplay];
		starX = starX + 16;
	}
}
		

- (void) dealloc
{
	
	// don't forget to call "super dealloc"
	[super dealloc];
}


@end
