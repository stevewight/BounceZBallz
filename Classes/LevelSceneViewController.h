//
//  LevelSceneViewController.h
//  bounceZballs
//
//  Created by Steve Wight on 2/5/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "zLevel.h"
#import "zSpring.h"
#import "zBlock.h"
#import "MyContactListener.h"
#import "zCloud.h"
#import "zBall.h"

// LevelScene Layer
@interface LevelScene : CCLayer
{
	b2World* world;
	GLESDebugDraw *m_debugDraw;
	
	zLevel *level;
	int ballCount;
	zBall *winningBall;
	int secondsCount;
	
	BOOL goalHasExploded;
	
	zGoal *goal;
	
	CCSprite *lastBallDot;
	
	CGSize screenSize;
	
	MyContactListener *_contactListener;
}

// returns a Scene that contains the HelloWorld as the only child
+(id) scene;

// initiate the object with level
-(id) initWithLevel:(int)localLevel;

// adds a new sprite at a given coordinate
-(void) addNewBallWithCoords:(CGPoint)p;

// adds a spring to the scene
-(void) addSpring:(zSpring*)spring;

// adds a block to the scene
-(void) addBlock:(zBlock*)block;

// add the goal to the level
-(void) addGoal:(zGoal*)theGoal;

// add a cloud to the level
-(void) addCloud:(zCloud*)cloud;

// when the cloud is done moving
-(void) cloudMoveFinished:(id)sender;

// cloud logic
-(void) cloudLogic:(ccTime)dt;

// loads the objects (blocks, springs, and the goal), returns the Level Object
-(void) loadLevel:(int)levelNumber;

// administrative calls to set up the physics environment
-(void) setUpWorld;

// set up the walls the ground and the sky
-(void) setUpGroundDef;

// ball has hit the goal (level has been completed)
-(void) levelComplete:(id)sender;

// increment the secondsCounter
-(void) incrementSecondsCount:(ccTime)dt;

// generate the grass background
-(void) generateGrassBackground;

// call explosion with given coords
-(void) explosionWithSprite:(CCSprite*)explosionSprite;

// play the proper sound effect
-(void) playSpringSoundEffect:(int)springCount;

// display the current level when scene initializes
-(void) displayCurrentLevelWithLevel:(int)theLevel;

// display a point where the last ball was dropped
-(void) addLastBallLocationWithCoords:(CGPoint)p;

// display a hint after a certain number of balls
-(void) displayHint;

// display the tutorial hints based on the hints array passed from tutorial object
-(void) displayTutorialHintsWithHints:(NSMutableArray*)hintsArray;

@end
