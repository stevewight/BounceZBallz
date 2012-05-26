//
//  zScoringLogic.h
//  bounceZballs
//
//  Created by Steve Wight on 2/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface zScoringLogic : NSObject {
	int ballCount;
	int secondsCount;
	int totalScore;
	int levelNumber;
}
@property(nonatomic,assign)int ballCount;
@property(nonatomic,assign)int secondsCount;
@property(nonatomic,assign)int totalScore;
@property(nonatomic,assign)int levelNumber;

-(id) initWithBallCount:(int)bc seconds:(int)s level:(int)l;
-(int) findPossiblePoints;
-(double) findBallPercent;
-(double) findSecondsPercent;
-(int) findStarCount;

@end
