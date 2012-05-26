//
//  LevelSummaryScene.h
//  bounceZballs
//
//  Created by Steve Wight on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "zBall.h"
#import "zScoringLogic.h"
#import "zLevel.h"

@interface LevelSummaryScene : CCLayer {

	int levelNumber;	
	int ballCount;
	int secondsCount;
	zScoringLogic *score;
	NSString *springCountString;
	NSString *ballCountString;
	zLevel *completedLevel;
	
}
@property (nonatomic,assign)int levelNumber;
@property (nonatomic,assign)int ballCount;
@property (nonatomic,assign)int secondsCount;
@property (nonatomic,retain)zScoringLogic *score;
@property (nonatomic,retain)NSString *springCountString;
@property (nonatomic,retain)NSString *ballCountString;
@property (nonatomic,retain)zLevel *completedLevel;

+(id)scene;

-(id)initWithLevelNumber:(int)level ballCount:(int)bc winBall:(zBall*)wBall seconds:(int)sec levelObject:(zLevel*)completeLevel;

-(void)onReplay:(id)sender;

-(void)onNext:(id)sender;

-(void)onSelectLevel:(id)sender;

-(void)onMainMenu:(id)sender;

-(void)createMenuWithSuccess:(BOOL)success;

-(void)displaySpringCount:(int)springCount ballTouchedCount:(int)ballTouched;

-(void)displayStats;

-(void)saveCompletedLevel;

-(void)displayStarsWithAmount:(int)amountOfStars;

@end
