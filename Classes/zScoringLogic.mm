//
//  zScoringLogic.m
//  bounceZballs
//
//  Created by Steve Wight on 2/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#define ballWeight .50
#define secondsWeight .50

#import "zScoringLogic.h"

@implementation zScoringLogic

@synthesize ballCount;
@synthesize secondsCount;
@synthesize levelNumber;
@synthesize totalScore;

-(id) initWithBallCount:(int)bc seconds:(int)s level:(int)l
{
	self.ballCount = bc;
	self.levelNumber = l;
	self.secondsCount = s;
	
	int pointsPossible = [self findPossiblePoints];
	
	double ballPercent = [self findBallPercent];
	double secondsPercent = [self findSecondsPercent];
	
	int ballPossiblePoints = (int) (.5*pointsPossible);
	int secondsPossiblePoints = (int) (.5*pointsPossible);
	
	self.totalScore = (ballPossiblePoints * ballPercent) + (secondsPossiblePoints * secondsPercent);
	
	return self;
}

-(int) findPossiblePoints
{
	int pp;//points possible 
	
	if (self.levelNumber==1) {
		pp = 20000;
	} else if (self.levelNumber==2) {
		pp = 30000;
	} else if (self.levelNumber==3){
		pp = 40000;
	} else if (self.levelNumber<6){
		pp = 50000;
	}else if (self.levelNumber<7) {
		pp = 60000;
	} else if (self.levelNumber<10) {
		pp = 80000;
	} else if (self.levelNumber<15) {
		pp = 100000;
	} else if (self.levelNumber<18) {
		pp = 120000;
	} else if (self.levelNumber<21) {
		pp = 150000;
	} else {
		pp = 200000;
	}

	return pp;
}

-(double) findBallPercent
{
	double bp;//ball percent
	
	if (self.ballCount==1) {
		bp = 1.0;
	} else if (self.ballCount==2) {
		bp = 0.95;
	} else if (self.ballCount==3) {
		bp = 0.90;
	} else if (self.ballCount<6) {
		bp = 0.85;
	} else if (self.ballCount<9) {
		bp = 0.80;
	} else if (self.ballCount<15) {
		bp = 0.70;
	} else if (self.ballCount<20) {
		bp = 0.60;
	} else if (self.ballCount<25) {
		bp = 0.50;
	} else if (self.ballCount<30) {
		bp = 0.40;
	} else {
		bp = 0.30;
	}
	
	return bp;
}

-(double) findSecondsPercent
{
	double sp;//seconds percent
	
	if (self.secondsCount<20) {
		sp = 1.0;
	} else if (self.secondsCount<30) {
		sp = 0.95;
	} else if (self.secondsCount<40) {
		sp = 0.90;
	} else if (self.secondsCount<50) {
		sp = 0.85;
	} else if (self.secondsCount<60) {
		sp = 0.80;
	} else if (self.secondsCount<70) {
		sp = 0.70;
	} else if (self.secondsCount<80) {
		sp = 0.60;
	} else if (self.secondsCount<100) {
		sp = 0.50;
	} else if (self.secondsCount<120) {
		sp = 0.40;
	} else {
		sp = 0.30;
	}
	
	return sp;
}

-(int) findStarCount
{
	int starCount;
	double totalPercent = [self findBallPercent] + [self findSecondsPercent];
	double finalPercent = totalPercent/2;
	
	if (finalPercent==1.0) {
		starCount = 7;
	} else if (finalPercent > .90) {
		starCount = 6;
	} else if (finalPercent > .80) {
		starCount = 5;
	} else if (finalPercent > .70) {
		starCount = 4;
	} else if (finalPercent > .60) {
		starCount = 3;
	} else if (finalPercent > .45) {
		starCount = 2;
	} else {
		starCount = 1;
	}
	
	return starCount;
}

- (void) dealloc
{
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
