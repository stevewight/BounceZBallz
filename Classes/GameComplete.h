//
//  GameComplete.h
//  bounceZballs
//
//  Created by Steve Wight on 2/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameComplete : CCLayer {
	int theTotalScore;
	BOOL isTheWinScreen;
}
@property(nonatomic,assign)int theTotalScore;
@property(nonatomic,assign)BOOL isTheWinScreen;

+(id) scene;
-(id) initWithMeasure:(BOOL)starsOrScore;
-(void) backToMenu;
-(void) onSelectLevel:(id)sender;
-(void) onMainMenu:(id)sender;
-(void) displayMenuWithSuccess:(BOOL)isSuccess;
-(BOOL) areAllLevelsComplete;
-(void) displayLevelsStatus;
-(void) onResetLevels:(id)sender;
-(void) displayTotalScore;
-(void) pickFinalStatment:(int)finalScore;
-(void)displayStarsWithAmount:(int)amountOfStars;
-(void) displaySmallStarWithAmount:(int)amountOfStars atCoords:(CGPoint)coords;

@end
