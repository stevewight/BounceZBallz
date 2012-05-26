//
//  LevelSceneViewController.mm
//  bounceZballs
//
//  Created by Steve Wight on 2/5/11.
//  Copyright __ZiatoGroup__ 2011. All rights reserved.
//


// Import the interfaces
#import "LevelSceneViewController.h"
#import "zBall.h"
#import "zLevel.h"
#import "MenuScene.h"
#import "LevelSummaryScene.h"
#import "zCloud.h"
#import "SimpleAudioEngine.h"
#import "zTutorial.h"

#include <iostream>
#include <algorithm>
using namespace std;

//Pixel to metres ratio. Box2D uses metres as the unit for measurement.
//This ratio defines how many pixels correspond to 1 Box2D "metre"
//Box2D is optimized for objects of 1x1 metre therefore it makes sense
//to define the ratio so that your most common object type is 1x1 metre.
#define PTM_RATIO 32

// enums that will be used as tags
enum {
	kTagTileMap = 1,
	kTagBatchNode = 1,
	kTagAnimation1 = 1,
	ballTagBatchNode = 2,
};


// LevelScene implementation
@implementation LevelScene

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	LevelScene *layer = [LevelScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// initialize your instance here
-(id) initWithLevel:(int)localLevel
{
	if( (self=[super init])) {
		ballCount = 0;
		secondsCount = 0;
		goalHasExploded = NO;
		
		//setUp calls
		[self setUpWorld];
		[self setUpGroundDef];
		[self generateGrassBackground];
		
		//load the level and all its objects
		[self loadLevel:localLevel];
		
		_contactListener = new MyContactListener();
		world->SetContactListener(_contactListener);
		
		//Create cloud at start
		[self cloudLogic:1];
		
		//display the current level when the scene initializes
		[self displayCurrentLevelWithLevel:localLevel];
		
		NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
		NSString *levelString = [NSString stringWithFormat:@"%i", localLevel];
		BOOL isLevelComplete = [userDefaults boolForKey:levelString];
		
		//if the level is less the 3 get the tutorial
		if (localLevel < 5 && !isLevelComplete) {
			zTutorial *tutorial = [[zTutorial alloc] initWithLevel:localLevel];
			[self displayTutorialHintsWithHints:[tutorial getTutorialHints]];
			[tutorial autorelease];
		}
		
		//schedule events to happen at intervals
		[self schedule: @selector(tick:)];
		[self schedule: @selector(cloudLogic:) interval:8.0];
		[self schedule: @selector(incrementSecondsCount:) interval:1.0];
		
	}
	return self;
}

-(void) draw
{
	// Default GL states: GL_TEXTURE_2D, GL_VERTEX_ARRAY, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
	// Needed states:  GL_VERTEX_ARRAY, 
	// Unneeded states: GL_TEXTURE_2D, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
	glDisable(GL_TEXTURE_2D);
	glDisableClientState(GL_COLOR_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	
	world->DrawDebugData();
	
	// restore default GL states
	glEnable(GL_TEXTURE_2D);
	glEnableClientState(GL_COLOR_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);

}

-(void) addNewBallWithCoords:(CGPoint)p
{	
	
	zBall *ball = [[zBall alloc] initWithCoords:p];
	
	[self addChild:ball.sprite z:5];

	// if the ball count is 13, then display the lastBallDrop image
	if (ballCount>11) {
		if (ballCount>12) {
			[self removeChild:lastBallDot cleanup:YES];
		}
		[self addLastBallLocationWithCoords:p];
	}
	
	//create the body
	b2BodyDef initBodyDef;
	
	initBodyDef.type = b2_dynamicBody;
	initBodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
	initBodyDef.userData = ball.sprite;
	
	b2Body *body = world->CreateBody(&initBodyDef);
	
	//create the shape
	b2CircleShape circle;
	circle.m_radius = 16.0/PTM_RATIO;
	
	//create the fixture
	b2FixtureDef initFixtureDef;
	
	initFixtureDef.shape = &circle;
	initFixtureDef.density = 1.0f;
	initFixtureDef.friction = 0.2f;
	initFixtureDef.restitution = 0.2f;
	
	body->CreateFixture(&initFixtureDef);
	
	ballCount++;
}

-(void) addLastBallLocationWithCoords:(CGPoint)p
{
	CCSprite *lastBallLocation = [CCSprite spriteWithFile:@"lastBallDot.png"];
	lastBallLocation.position = ccp(p.x,p.y);
	[self addChild:lastBallLocation z:10];
	lastBallDot = lastBallLocation;
}

-(void) displayHint
{
	CCSprite *hintSprite = [CCSprite spriteWithFile:@"hintLocationPurple.png"];
	hintSprite.position = level.hintLocation;
	[self addChild:hintSprite z:1];
	
	id fadeOut = [CCFadeOut actionWithDuration:.5];
	//[hintSprite runAction:fadeOut];
	
	id theFadeIn = [CCFadeIn actionWithDuration:.5];
	
	CCSequence *sequence = [CCSequence actions:fadeOut,theFadeIn,fadeOut,theFadeIn,fadeOut,nil];
	[hintSprite runAction:sequence];
	
	level.hintShown = YES;
}

-(void) setUpWorld
{
	// enable touches
	self.isTouchEnabled = YES;
	
	screenSize = [CCDirector sharedDirector].winSize;
	CCLOG(@"Screen width %0.2f screen height %0.2f",screenSize.width,screenSize.height);
	
	// Define the gravity vector.
	b2Vec2 gravity;
	gravity.Set(0.0f, -10.0f);// basic gravity = 0.0f, -10.0f
	
	// Let the bodies sleep
	// This will speed up the physics simulation
	bool doSleep = true;
	
	// Construct a world object, which will hold and simulate the rigid bodies.
	world = new b2World(gravity, doSleep);
	
	world->SetContinuousPhysics(true);
	
}

-(void) setUpGroundDef
{
	//Set up sprite for GroundDef
	CCSprite *groundSprite = [[CCSprite alloc] init];
	groundSprite.tag = 0;
	
	// Define the ground body.
	b2BodyDef groundBodyDef;
	groundBodyDef.position.Set(0, 0); // bottom-left corner
	
	groundBodyDef.userData = groundSprite;
	
	// Call the body factory which allocates memory for the ground body
	// from a pool and creates the ground box shape (also from a pool).
	// The body is also added to the world.
	b2Body* groundBody = world->CreateBody(&groundBodyDef);
	
	// Define the ground box shape.
	b2PolygonShape groundBox;		
	
	// bottom
	groundBox.SetAsEdge(b2Vec2(0,0), b2Vec2(screenSize.width/PTM_RATIO,0));
	groundBody->CreateFixture(&groundBox,0);
	
	// top
	groundBox.SetAsEdge(b2Vec2(0,screenSize.height/PTM_RATIO), b2Vec2(screenSize.width/PTM_RATIO,screenSize.height/PTM_RATIO));
	groundBody->CreateFixture(&groundBox,0);
	
	// left
	groundBox.SetAsEdge(b2Vec2(0,screenSize.height/PTM_RATIO), b2Vec2(0,0));
	groundBody->CreateFixture(&groundBox,0);
	
	// right
	groundBox.SetAsEdge(b2Vec2(screenSize.width/PTM_RATIO,screenSize.height/PTM_RATIO), b2Vec2(screenSize.width/PTM_RATIO,0));
	groundBody->CreateFixture(&groundBox,0);
}

-(void) loadLevel:(int)levelNumber
{
	if (level != nil) {
		[level.springs removeAllObjects];
		[level.blocks removeAllObjects];
		goal = nil;
		levelNumber = nil;
	}
	
	level = [[zLevel alloc] initWithLevel:levelNumber];// variable should be levelNumber
	
	//add the springs for the given level
	for (zSpring *spr in level.springs) {
		[self addSpring:spr];
	}
	
	//add the box for the given level
	for (zBlock *blk in level.blocks) {
		[self addBlock:blk];
	}
	
	//add the goal to the given level
	[self addGoal:level.goal];
	goal = level.goal;
	
	//add the background
	CCSprite *bg = level.background;
	bg.position = ccp(240,160);
	[self addChild:bg z:0];
	
	
	
}

-(void) addSpring:(zSpring*)spring
{
	[self addChild:spring.sprite z:3];
	
	CGPoint p = spring.coords;
	//static triangle one
	b2Vec2 vertices[3];
	int32 count = 3;
	
	switch (spring.springType) {
		case 0://rightFacingUpLow
			vertices[0].Set(0.0f,0.0f);
			vertices[1].Set(2.0f,0.0f);
			vertices[2].Set(0.0f,1.0f);
			break;
		case 1://rightFacingUpMed
			vertices[0].Set(0.0f,0.0f);
			vertices[1].Set(1.5,0.0f);
			vertices[2].Set(0.0f,1.5f);
			break;
		case 2://rightFacingUpHigh
			vertices[0].Set(0.0f,0.0f);
			vertices[1].Set(1.0f,0.0f);
			vertices[2].Set(0.0f,2.0f);
			break;
		case 3://rightFacingDownHigh
			vertices[0].Set(0.0f,0.0f);
			vertices[1].Set(1.0f,2.0f);
			vertices[2].Set(0.0f,2.0f);
			break;
		case 4://rightFacingDownMed
			vertices[0].Set(0.0f,0.0f);
			vertices[1].Set(1.5f,1.5f);
			vertices[2].Set(0.0f,1.5f);
			break;
		case 5://rightFacingDownLow
			vertices[0].Set(0.0f,0.0f);
			vertices[1].Set(2.0f,1.0f);
			vertices[2].Set(0.0f,1.0f);
			break;
		case 6://leftFacingUpLow
			vertices[0].Set(0.0f,0.0f);
			vertices[1].Set(2.0f,0.0f);
			vertices[2].Set(2.0f,1.0f);
			break;
		case 7://leftFacingUpMed
			vertices[0].Set(0.0f,0.0f);
			vertices[1].Set(1.5f,0.0f);
			vertices[2].Set(1.5f,1.5f);
			break;
		case 8://leftFacingUpHigh
			vertices[0].Set(0.0f,0.0f);
			vertices[1].Set(1.0f,0.0f);
			vertices[2].Set(1.0f,2.0f);
			break;
		case 9://leftFacingDownHigh
			vertices[0].Set(1.0f,0.0f);
			vertices[1].Set(1.0f,2.0f);
			vertices[2].Set(0.0f,2.0f);
			break;
		case 10://leftFacingDownMed
			vertices[0].Set(1.5f,0.0f);
			vertices[1].Set(1.5f,1.5f);
			vertices[2].Set(0.0f,1.5f);
			break;
		case 11://leftFacingDownLow
			vertices[0].Set(2.0f,0.0f);
			vertices[1].Set(2.0f,1.0f);
			vertices[2].Set(0.0f,1.0f);
			break;
		default:
			vertices[0].Set(0.0f,0.0f);
			vertices[1].Set(1.5f,0.0f);
			vertices[2].Set(0.0f,2.0f);
			break;
	}
	
	b2BodyDef springBodyDef;
	springBodyDef.type = b2_staticBody;
	springBodyDef.position.Set(p.x/PTM_RATIO ,p.y/PTM_RATIO);
	springBodyDef.userData = spring.sprite;
	b2Body *body = world->CreateBody(&springBodyDef);
	
	b2PolygonShape polygon;
	polygon.Set(vertices, count);
	
	b2FixtureDef springShapeDef;
	springShapeDef.shape = &polygon;
	springShapeDef.density = 1.0f;
	springShapeDef.friction = 0.2f;
	springShapeDef.restitution = 1.6f;
	body->CreateFixture(&springShapeDef);

}

-(void) addBlock:(zBlock*)block
{
	[self addChild:block.sprite z:2];
	
	CGPoint p = block.coords;
	
	b2BodyDef bodyDef;
	bodyDef.type = b2_staticBody;
	
	bodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
	bodyDef.userData = block.sprite;
	b2Body *body = world->CreateBody(&bodyDef);
	
	// Define another box shape for our dynamic body.
	b2PolygonShape dynamicBox;
	switch (block.blockType) {
		case 0:
			dynamicBox.SetAsBox(0.5f, 0.5f);//These are mid points for our 1m box
			break;
		case 1:
			dynamicBox.SetAsBox(1.0f, 0.1f);
			break;
		case 2:
			dynamicBox.SetAsBox(0.1f, 1.0f);
			break;
		case 3:
			dynamicBox.SetAsBox(1.0f, 0.5f);
			break;
		default:
			dynamicBox.SetAsBox(1.0f, .1f);
			break;
	}
	
	// Define the dynamic body fixture.
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &dynamicBox;	
	fixtureDef.density = 1.0f;
	fixtureDef.friction = 0.3f;
	body->CreateFixture(&fixtureDef);
}

-(void) addGoal:(zGoal*)theGoal
{
	[self addChild:theGoal.sprite z:6];
	CGPoint p = theGoal.coords;
	
	//Create ball body and shape
	b2BodyDef goalBodyDef;
	goalBodyDef.type = b2_staticBody;
	
	goalBodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
	goalBodyDef.userData = theGoal.sprite;
	b2Body *body = world->CreateBody(&goalBodyDef);
	
	b2CircleShape circle;
	circle.m_radius = 16.0/PTM_RATIO;
	
	b2FixtureDef goalShapeDef;
	goalShapeDef.shape = &circle;
	goalShapeDef.density = 1.0f;
	goalShapeDef.friction = 0.2f;
	goalShapeDef.restitution = 0.2f;
	body->CreateFixture(&goalShapeDef);	
}

-(void) addCloud:(zCloud*)cloud
{
	[self addChild:cloud.sprite z:cloud.zIndex];
	
	id actionMove = [CCMoveTo actionWithDuration:cloud.speedDuration 
										position:ccp(600,cloud.coords.y)];
	
	id actionMoveDone = [CCCallFuncN actionWithTarget:self 
											 selector:@selector(cloudMoveFinished:)];
	
	[cloud.sprite runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
}

-(void) cloudMoveFinished:(id)sender
{
	CCSprite *sprite = (CCSprite *)sender;
	[self removeChild:sprite cleanup:YES];
}

-(void)cloudLogic:(ccTime)dt
{
	zCloud *cloud = [[zCloud alloc] init];
	cloud.sprite.position = cloud.coords;
	[self addCloud:cloud];
	
	[cloud autorelease];
}

-(void) generateGrassBackground
{
	CCSprite *grass = [CCSprite spriteWithFile:@"grass_long.png"];
	grass.position = ccp(240,10);
	[self addChild:grass z:1];
	
	//Create the random grass sprites and place them
	for (int i=1; i<6; i++) {
		CCSprite *grassImage;
		NSString *spriteFileName;
		
		//randomly select a sprite file name
		switch (arc4random() % 5) {
			case 0:
				spriteFileName = @"grass_1.png";
				break;
			case 1:
				spriteFileName = @"grass_2.png";
				break;
			case 2:
				spriteFileName = @"grass_3.png";
				break;
			case 3:
				spriteFileName = @"grass_4.png";
				break;
			case 4:
				spriteFileName = @"grass_5.png";
				break;
			default:
				spriteFileName = @"grass_1.png";
				break;
		}
		
		
		int rand = arc4random() % 480;
		grassImage = [CCSprite spriteWithFile:spriteFileName];
		grassImage.position = ccp(rand,10);
		
		[self addChild:grassImage z:8];
	}
}

-(void) tick: (ccTime) dt
{
	//check the ball count to see if user needs a 'hint'
	if (!level.hintShown) {
		
		if (ballCount==31)
		{
			[self displayHint];
		}
		
	}
	
	
	int32 velocityIterations = 8;//8
	int32 positionIterations = 1;//1
	
	float maxStep = 0.03;
	float progress = 0.0;
	
	while (progress < dt) {
		
		float step = min((dt-progress), maxStep);
	
		// Instruct the world to perform a single step of simulation. It is
		// generally best to keep the time step and iterations fixed.
		world->Step(step, velocityIterations, positionIterations);
	
		//Iterate over the bodies in the physics world
		for (b2Body* b = world->GetBodyList(); b; b = b->GetNext())
		{
			if (b->GetUserData() != NULL) {
				//Synchronize the AtlasSprites position and rotation with the corresponding body
				CCSprite *myActor = (CCSprite*)b->GetUserData();
				myActor.position = CGPointMake( b->GetPosition().x * PTM_RATIO, b->GetPosition().y * PTM_RATIO);
				myActor.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
			
				//if the object is a ball and sleeping, destroy
				if (myActor.tag == 1 && b->IsAwake() == false) {
				
					[self explosionWithSprite:myActor];
					[self removeChild:myActor cleanup:YES];
				
					world->DestroyBody(b);
					// end of sleep and destroy
				}
			
			}	
		}
		
		
	
	//Iterates through all of the bufferd contact points
	std::vector<b2Body *>toDestroy;
	std::vector<MyContact>::iterator pos;
	for(pos = _contactListener->_contacts.begin(); 
		pos != _contactListener->_contacts.end(); ++pos) {
		MyContact contact = *pos;
		
		b2Body *bodyA = contact.fixtureA->GetBody();
		b2Body *bodyB = contact.fixtureB->GetBody();
		if (bodyA->GetUserData() != NULL && bodyB->GetUserData() != NULL) {
			CCSprite *spriteA = (CCSprite *) bodyA->GetUserData();
			CCSprite *spriteB = (CCSprite *) bodyB->GetUserData();
			
			// Sprite B = block, Sprite A = ball
			if (spriteA.tag == 3 && spriteB.tag == 1) {
				if (std::find(toDestroy.begin(), toDestroy.end(), bodyB) 
					== toDestroy.end()) {
					toDestroy.push_back(bodyB);
				}
			}
	
			// Sprite A = goal, Sprite B = ball
			else if (spriteA.tag == 4 && spriteB.tag == 1) {
				if (std::find(toDestroy.begin(), toDestroy.end(), bodyA) == toDestroy.end() &&
					std::find(toDestroy.begin(), toDestroy.end(), bodyB) == toDestroy.end()){
					toDestroy.push_back(bodyA);
					toDestroy.push_back(bodyB);
					
					goalHasExploded = YES;
					
					//set the winning ball (passed to LevelSummaryScene)
					winningBall = (zBall*) spriteB.userData;
				}
			}
			  
			// Sprite A = ball, Sprite B = ball
			else if (spriteA.tag == 1 && spriteB.tag == 1) {
				if (std::find(toDestroy.begin(), toDestroy.end(), bodyA) == toDestroy.end() &&
					std::find(toDestroy.begin(), toDestroy.end(), bodyB) == toDestroy.end()){
					toDestroy.push_back(bodyA);
					toDestroy.push_back(bodyB);
					
				}
			}
	
			// Sprite A = spring, Sprite B = ball
			else if (spriteA.tag == 2 && spriteB.tag == 1) {
				//load the sprites userData (reference to object)
				zBall *ball = (zBall*) spriteB.userData;
				zSpring *contactSpring = (zSpring*) spriteA.userData;
				
				//fix the repeating of the sound if hitting same spring 
				if ([ball.lastSpringHit isEqual:contactSpring]) {
					ball.repeatSpringHit = ball.repeatSpringHit + 1;
				} else {
					ball.repeatSpringHit = 0;
				}
				
				//add it to the array of springs that have been touched by the calling ball
				[ball addContactSpring:contactSpring];
				
				int contactSpringsCount = [ball.contactSprings count];
				if (ball.repeatSpringHit<9) {
					//play the spring sound effect
					[self playSpringSoundEffect:contactSpringsCount];
				}
				
				//set the balls lastSpringHit to the current spring
				ball.lastSpringHit = contactSpring;
			}
		}
	}
	
	//loop through and destory the necessary body's from the world
	std::vector<b2Body *>::iterator pos2;
	for(pos2 = toDestroy.begin(); pos2 != toDestroy.end(); ++pos2) {
		b2Body *body = *pos2;     
		if (body->GetUserData() != NULL) {
			CCSprite *sprite = (CCSprite *) body->GetUserData();
			
			//sprite to destroy is BALL
			if (sprite.tag == 1) {
				//set explosion point to sprite's current positon and explode
				[self explosionWithSprite:sprite];
				[[SimpleAudioEngine sharedEngine] playEffect:@"explosion3.caf"];
			}
			//sprite to destroy is GOAL
			else if (sprite.tag == 4) {
				[self explosionWithSprite:sprite];
				
				if ([level.springs count] == [winningBall.contactSprings count] ) {
					CCLabelBMFont *successLabel = [CCLabelBMFont labelWithString:@"Great Success" fntFile:@"ErasDemiRed.fnt"]; 
					successLabel.position = ccp(240,160);
					
					id fadeIn = [CCFadeIn actionWithDuration:1];
					[successLabel runAction:fadeIn];
					
					[self addChild:successLabel z:9];
					
					[[SimpleAudioEngine sharedEngine] playEffect:@"winEffectFlute.caf"];
				} else {
					CCLabelBMFont *successLabel = [CCLabelBMFont labelWithString:@"Better Luck Next Time" fntFile:@"ErasDemiRed.fnt"]; 
					successLabel.position = ccp(240,160);
					
					id fadeIn = [CCFadeIn actionWithDuration:1];
					[successLabel runAction:fadeIn];
					
					[self addChild:successLabel z:9];
					
					[[SimpleAudioEngine sharedEngine] playEffect:@"sorryEffect_2.caf"];
				}

				//level is complete set timer to call levelComplete method in 3 seconds
				[self performSelector:@selector(levelComplete:) withObject:self afterDelay:3.0];
			}
			
			[self removeChild:sprite cleanup:YES];
		}
		world->DestroyBody(body);
	}
		
		progress+= step;
	}//end while loop
	
	world->ClearForces();
	
}

-(void) displayTutorialHintsWithHints:(NSMutableArray*)hintsArray
{
	
	for (CCSprite *hintSprite in hintsArray) {

		[self addChild:hintSprite z:7];
		
		id fadeOut = [CCFadeOut actionWithDuration:2];
		
		id theFadeIn = [CCFadeIn actionWithDuration:2];
		
		CCSequence *sequence = [CCSequence actions:fadeOut,theFadeIn,fadeOut,theFadeIn,fadeOut,nil];
		[hintSprite runAction:sequence];
		
	}
}

-(void) explosionWithSprite:(CCSprite*)explosionSprite;
{
	int expType = explosionSprite.tag;
	
	if (expType==1) {
		//Prepare the explosion object and get the points
		CCParticleSun *explosion = [[CCParticleSun alloc] initWithTotalParticles:50];
		explosion.texture = [[CCTextureCache sharedTextureCache] addImage:@"ball.png"];
		explosion.life = 0.5;
		explosion.duration = 1.5;
		explosion.speed = 75;
		explosion.position = explosionSprite.position;
		if (explosion.active) {
			[self addChild:explosion z:7];
		} else {
			[self explosionWithSprite:explosionSprite];
		}

		//explosion.autoRemoveOnFinish = YES;
		
	} else if (expType==4) {
		//Prepare the explosion object for the goal
		CCParticleMeteor *goalExplosion = [[CCParticleMeteor alloc] initWithTotalParticles:50];
		goalExplosion.texture = [[CCTextureCache sharedTextureCache] addImage:@"goalBall.png"];
		goalExplosion.life = 0.5;
		goalExplosion.duration = 1.5;
		goalExplosion.speed = 75;
		goalExplosion.position = explosionSprite.position;
		if (goalExplosion.active) {
			[self addChild:goalExplosion z:7];
		} else {
			[self explosionWithSprite:goal.sprite];
		}

		//goalExplosion.autoRemoveOnFinish = YES;
	} 
	
	// if the ball that is being destroyed is not the winnning ball
	zBall *theBall = (zBall*)explosionSprite.userData;
	
	if (![theBall isEqual:winningBall]) {
		[theBall autorelease];
	}
	
}

-(void) playSpringSoundEffect:(int)springCount
{
	//play C major scale (springCount)
	switch (springCount)
	{
	case 1:
		[[SimpleAudioEngine sharedEngine] playEffect:@"noteC.caf"];
		break;
	case 2:
		[[SimpleAudioEngine sharedEngine] playEffect:@"noteD.caf"];
		break;
	case 3:
		[[SimpleAudioEngine sharedEngine] playEffect:@"noteE.caf"];
		break;
	case 4:
		[[SimpleAudioEngine sharedEngine] playEffect:@"noteF.caf"];
		break;
	case 5:
		[[SimpleAudioEngine sharedEngine] playEffect:@"noteG.caf"];
		break;
	case 6:
		[[SimpleAudioEngine sharedEngine] playEffect:@"noteA.caf"];
		break;
	case 7:
		[[SimpleAudioEngine sharedEngine] playEffect:@"noteB.caf"];
		break;
	case 8:
		[[SimpleAudioEngine sharedEngine] playEffect:@"noteC8th.caf"];
		break;
	default:
		[[SimpleAudioEngine sharedEngine] playEffect:@"noteC.caf"];
		break;
	}
	
}

-(void) levelComplete:(id)sender
{
	LevelSummaryScene *scene = [[LevelSummaryScene alloc] initWithLevelNumber:level.levelNumber ballCount:ballCount winBall:winningBall seconds:secondsCount levelObject:level];
	CCScene *theScene = (CCScene*) scene;
	[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:.5 scene:theScene]];	
}

-(void) incrementSecondsCount:(ccTime)dt
{
	secondsCount++;
}

-(void) displayCurrentLevelWithLevel:(int)theLevel
{
	//Display the level number
	NSString *levelNumberString = [NSString stringWithFormat:@"%i", theLevel];
	NSString *levelStartString = @"Level ";
	NSString *levelString = [levelStartString stringByAppendingString:levelNumberString];
	
	CCLabelBMFont *levelStartLabel = [CCLabelBMFont labelWithString:levelString fntFile:@"ErasDemiRed.fnt"]; 
	levelStartLabel.position = ccp(240,160);
	[self addChild:levelStartLabel z:9];
	
	id fadeOut = [CCFadeOut actionWithDuration:4];
	[levelStartLabel runAction:fadeOut];
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	//Add a new body/atlas sprite at the touched location
	for( UITouch *touch in touches ) {
		CGPoint location = [touch locationInView: [touch view]];
		
		location = [[CCDirector sharedDirector] convertToGL: location];
		
		[self addNewBallWithCoords:location];
	}
}

- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	delete world;
	world = NULL;
	
	delete m_debugDraw;
	
	delete _contactListener;
	_contactListener = NULL;
	
	[winningBall release];
	[level release];
	[goal release];

	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
