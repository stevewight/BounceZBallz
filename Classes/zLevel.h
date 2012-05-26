//
//  zLevel.h
//  bounceZballs
//
//  Created by Steve Wight on 2/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "zGoal.h"
#import "zThing.h"


@interface zLevel : NSObject {
	NSMutableArray *springs;
	NSMutableArray *blocks;
	NSMutableArray *balls;
	zGoal *goal;
	CCSprite *background;
	int levelNumber;
	BOOL isLevelComplete;
	
	CGPoint hintLocation;
	BOOL hintShown;
}
@property(nonatomic,retain)NSMutableArray *springs;
@property(nonatomic,retain)NSMutableArray *blocks;
@property(nonatomic,retain)NSMutableArray *balls;
@property(nonatomic,retain)zGoal *goal;
@property(nonatomic,retain)CCSprite *background;
@property(nonatomic,assign)int levelNumber;
@property(nonatomic,assign)BOOL isLevelComplete;
@property(nonatomic,assign)CGPoint hintLocation;
@property(nonatomic,assign)BOOL hintShown;

-(id)initWithLevel:(int)level;
-(void)loadLevelThings;
-(void)loadLevelBackground;

-(void)addSpringWithX:(int)theX withY:(int)theY withType:(int)theType;
-(void)addBlockWithX:(int)theX withY:(int)theY withType:(int)theType;

@end
