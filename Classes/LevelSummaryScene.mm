//
//  LevelSummaryScene.m
//  bounceZballs
//
//  Created by Steve Wight on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#define kLastCompletedLevel @"lastCompletedLevel"

#import "LevelSummaryScene.h"
#import "LevelSceneViewController.h"
#import "MenuScene.h"
#import "LevelSelectScene.h"
#import "zScoringLogic.h"
#import "GameComplete.h"
#import "zLevel.h"
#import "SimpleAudioEngine.h"

@implementation LevelSummaryScene

@synthesize levelNumber;
@synthesize ballCount;
@synthesize springCountString;
@synthesize ballCountString;
@synthesize secondsCount;
@synthesize score;
@synthesize completedLevel;

+(id) scene
{
	CCScene *scene = [CCScene node];
	
	LevelSummaryScene *layer = [LevelSummaryScene node];
	
	[scene addChild:layer];
	
	return scene;
}

-(id) initWithLevelNumber:(int)level ballCount:(int)bc winBall:(zBall*)wBall seconds:(int)sec levelObject:(zLevel*)completeLevel
{
	if ((self = [super init])) {
		
		self.levelNumber = level;
		self.ballCount = bc;
		self.secondsCount = sec;
		self.completedLevel = completeLevel;
		
		//Create the background and add it to the scene
		CCSprite *bg = [CCSprite spriteWithFile:@"lightBlueBackground.png"];
		bg.position = ccp(240,160);
		[self addChild:bg z:0];
		
		//Create the header for the scene
		CCSprite *header = [CCSprite spriteWithFile:@"levelSummaryHeader.png"];
		header.position = ccp(240,270);
		[self addChild:header z:1];
		
		//Display the current level number in the header
		NSString *currentLevel = [NSString stringWithFormat:@"%i", levelNumber];
		
		CCLabelBMFont *bmLabel = [CCLabelBMFont labelWithString:currentLevel fntFile:@"ErasBoldRed.fnt"]; 
		bmLabel.position = ccp(188,280);
		[self addChild:bmLabel z:2];
		
		//Check to see if the winning ball hit every spring 
		zLevel *level = [[zLevel alloc] initWithLevel:levelNumber];
		NSMutableArray *springsFromLevel = level.springs;
		[level autorelease];
		NSMutableSet *ballTouchedSprings = wBall.contactSprings;
		int springsFromLevelCount = [springsFromLevel count];
		int ballTouchedSpringsCount = [ballTouchedSprings count];
		BOOL springSuccess;
		
		[self displayStats];
		
		if ([springsFromLevel count] == [ballTouchedSprings count]) {
			//The winning ball touched every spring
			springSuccess = YES;
			self.score = [[zScoringLogic alloc] initWithBallCount:self.ballCount 
													 seconds:self.secondsCount 
													   level:self.levelNumber];
			
			NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
		
			[numFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
			NSNumber *totalScoreNumber = [NSNumber numberWithInt:score.totalScore];
			NSString *formattedTotalScore = [numFormatter stringFromNumber:totalScoreNumber];
			
			//display the total score
			NSString *startString = @"Total Score:  ";
					
			CCLabelBMFont *totalScoreLabel = [CCLabelBMFont labelWithString:startString fntFile:@"ErasMediumBlue.fnt"]; 
			totalScoreLabel.position = ccp(185,176);
			[self addChild:totalScoreLabel z:2];
			
			CCLabelBMFont *totalScoreLabelNumber = [CCLabelBMFont labelWithString:formattedTotalScore fntFile:@"ErasDemiRed.fnt"]; 
			totalScoreLabelNumber.position = ccp(300,176);
			[self addChild:totalScoreLabelNumber z:2];
			
			[self displayStarsWithAmount:[score findStarCount]];
			[self saveCompletedLevel];
			
			[numFormatter autorelease];
		}
		else {
			//The winning ball did NOT touch every spring
			springSuccess = NO;

			[self displaySpringCount:springsFromLevelCount ballTouchedCount:ballTouchedSpringsCount];
			
			NSString *didntHitAllSprings = @"You didn't hit all the springs!";
			CCLabelBMFont *didntHitLabel = [CCLabelBMFont labelWithString:didntHitAllSprings fntFile:@"ErasDemiRed.fnt"]; 
			didntHitLabel.position = ccp(240,128);
			[self addChild:didntHitLabel z:2];
			
		}
		
		[self createMenuWithSuccess:springSuccess];
		[self.completedLevel release];
		
	}
	return (CCScene*) self;
}

-(void)onReplay:(id)sender
{
	LevelScene *scene = [[LevelScene alloc] initWithLevel:levelNumber];
	CCScene *newScene = (CCScene*)scene;
	[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInL transitionWithDuration:.5 scene:newScene]];
	
	[[SimpleAudioEngine sharedEngine] playEffect:@"movinOn.caf"];
}

-(void)onNext:(id)sender
{
	CCScene *newScene;
	
	if (levelNumber<21) {
		int nextLevel = levelNumber+1;
		LevelScene *scene = [[LevelScene alloc] initWithLevel:nextLevel];
		newScene = (CCScene*)scene;
	} else {
		
		GameComplete *scene = [[GameComplete alloc] initWithMeasure:YES];
		newScene = (CCScene*)scene;
		
	}
	
	[[SimpleAudioEngine sharedEngine] playEffect:@"movinOn.caf"];
	
	[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:.5 scene:newScene]];
	
}

-(void)onMainMenu:(id)sender
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:.5 scene:[MenuScene node]]];
	[[SimpleAudioEngine sharedEngine] playEffect:@"noteG.caf"];
}

-(void)onSelectLevel:(id)sender
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:.5 scene:[LevelSelectScene node]]];
	[[SimpleAudioEngine sharedEngine] playEffect:@"noteC.caf"];
}
	
-(void)createMenuWithSuccess:(BOOL)success
{
	//Create the menu items and add them to the scene
	CCMenuItemImage *itemReplay = [CCMenuItemImage itemFromNormalImage:@"replayMenuItem.png" selectedImage:@"replayMenuItem_selected.png" 
																target:self
															  selector:@selector(onReplay:)];
	CCMenuItemImage *itemNext = [CCMenuItemImage itemFromNormalImage:@"nextMenuItem.png" selectedImage:@"nextMenuItem_selected.png"
															  target:self
															selector:@selector(onNext:)];
	
	CCMenuItemImage *itemMainMenu = [CCMenuItemImage itemFromNormalImage:@"mainMenuItem.png" selectedImage:@"mainMenuItem_selected.png"
																  target:self
																selector:@selector(onMainMenu:)];
	CCMenuItemImage *itemLevelSelect = [CCMenuItemImage itemFromNormalImage:@"selectLevelMenuItem.png" selectedImage:@"selectLevelMenuItem_selected.png"
																	 target:self
																   selector:@selector(onSelectLevel:)];
	
	CCMenu *menu = [CCMenu menuWithItems:nil];
	
	CCMenu *menuTwo = [CCMenu menuWithItems:nil];
	
	
	if (success) {
		
		[menu addChild:itemReplay];
		[menu addChild:itemNext];
		[menuTwo addChild:itemMainMenu];
		[menuTwo addChild:itemLevelSelect];
				
		
	} else {
			
		[menu addChild:itemReplay];
		[menuTwo addChild:itemMainMenu];
	
	}
	
	menu.position = ccp(240,75);
	[menu alignItemsHorizontallyWithPadding:3.5];
	[self addChild:menu];
	
	menuTwo.position = ccp(240,31);
	[menuTwo alignItemsHorizontallyWithPadding:3.5];
	[self addChild:menuTwo];

}

-(void)displaySpringCount:(int)springCount ballTouchedCount:(int)ballTouched
{
	//Display the springs hit ratio
	NSString *springStartString = @"Spring's Hit:  ";
	NSString *ballTouchedString = [NSString stringWithFormat:@"%i", ballTouched];
	NSString *ofString = @" of ";
	NSString *springString = [NSString stringWithFormat:@"%i", springCount];
	NSString *ratioString = [ballTouchedString stringByAppendingString:ofString];
	NSString *ratioStringFinal = [ratioString stringByAppendingString:springString];
	//NSString *springFinalString = [springStartString stringByAppendingString:ratioStringFinal];
	
	CCLabelBMFont *springStartLabel = [CCLabelBMFont labelWithString:springStartString fntFile:@"ErasMediumBlue.fnt"]; 
	springStartLabel.position = ccp(185,176);
	[self addChild:springStartLabel z:2];
	
	CCLabelBMFont *springRatioLabel = [CCLabelBMFont labelWithString:ratioStringFinal fntFile:@"ErasDemiRed.fnt"]; 
	springRatioLabel.position = ccp(300,176);
	[self addChild:springRatioLabel z:2];
	
}

-(void)displayStats
{	
	//Display the balls used
	NSString *ballStartString = @"Ball's Used:  ";
	NSString *ballsUsedString = [NSString stringWithFormat:@"%i", self.ballCount];
	//NSString *ballFinalString = [ballStartString stringByAppendingString:ballsUsedString];
	
	CCLabelBMFont *ballsUsedLabelNumber = [CCLabelBMFont labelWithString:ballStartString fntFile:@"ErasMediumBlue.fnt"]; 
	ballsUsedLabelNumber.position = ccp(185,238);
	[self addChild:ballsUsedLabelNumber z:2];
	
	CCLabelBMFont *ballsUsedStringNumber = [CCLabelBMFont labelWithString:ballsUsedString fntFile:@"ErasDemiRed.fnt"]; 
	ballsUsedStringNumber.position = ccp(300,238);
	[self addChild:ballsUsedStringNumber z:2];
	
	//Display the Seconds taken
	NSString *timeStartString = @"Time Taken:  ";
	NSString *timeString = [NSString stringWithFormat:@"%i", self.secondsCount];
	NSString *secString = [timeString stringByAppendingString:@" sec"];
	//NSString *timeFinalString = [timeStartString stringByAppendingString:secString];
	
	CCLabelBMFont *timeStartLabel = [CCLabelBMFont labelWithString:timeStartString fntFile:@"ErasMediumBlue.fnt"]; 
	timeStartLabel.position = ccp(185,207);
	[self addChild:timeStartLabel z:2];

	CCLabelBMFont *secStringLabel = [CCLabelBMFont labelWithString:secString fntFile:@"ErasDemiRed.fnt"]; 
	secStringLabel.position = ccp(300,207);
	[self addChild:secStringLabel z:2];
	
}

-(void)displayStarsWithAmount:(int)amountOfStars
{
	int starX = 65;
	int starY = 131;
	
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


-(void)saveCompletedLevel
{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	
	completedLevel.isLevelComplete = YES;
	
	//set true because level is complete
	NSString *levelString = [NSString stringWithFormat:@"%i", levelNumber];
	[userDefaults setBool:YES forKey:levelString];
	
	//set the score (userDefaults)
	NSString *levelScoreString = @"levelScore";
	NSString *levelScoreKey = [levelScoreString stringByAppendingString:levelString];
	//NSInteger oldLevelScore = [userDefaults integerForKey:levelScoreKey];
	
	[userDefaults setInteger:score.totalScore forKey:levelScoreKey];
	
	
	//set the number of stars (userDefaults)
	NSString *levelStarString = @"star";
	NSString *levelStarKey = [levelStarString stringByAppendingString:levelString];
	
	[userDefaults setInteger:[score findStarCount] forKey:levelStarKey];
	

	[userDefaults synchronize];
	
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	[score release];
	[springCountString release];
	[ballCountString release];
	[completedLevel release];
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
