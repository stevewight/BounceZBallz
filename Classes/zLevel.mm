//
//  zLevel.m
//  bounceZballs
//
//  Created by Steve Wight on 2/7/11.
//  Copyright 2011 __ZiatoGroup__. All rights reserved.
//

#import "zLevel.h"
#import "zBall.h"
#import "zSpring.h"
#import "zBlock.h"
#import "zGoal.h"


@implementation zLevel

@synthesize springs;
@synthesize blocks;
@synthesize balls;
@synthesize goal;
@synthesize levelNumber;
@synthesize background;
@synthesize isLevelComplete;
@synthesize hintLocation;
@synthesize hintShown;

-(id)initWithLevel:(int)level
{
	springs = [[NSMutableArray alloc] init];
	blocks = [[NSMutableArray alloc] init];
	balls = [[NSMutableArray alloc] init];
	self.levelNumber = level;
	self.isLevelComplete = NO;
	self.hintShown = NO;
	
	[self loadLevelThings];
	[self loadLevelBackground];
	
	return self;
}

-(void)loadLevelThings
{
	switch (self.levelNumber) {
		case 1:
			//load level 1
			[self addSpringWithX:0 withY:0 withType:0];
			
			[self addBlockWithX:240 withY:25 withType:0];
			[self addBlockWithX:205 withY:25 withType:0];
			[self addBlockWithX:275 withY:25 withType:0];
			[self addBlockWithX:240 withY:60 withType:0];
			[self addBlockWithX:205 withY:60 withType:0];
			[self addBlockWithX:275 withY:60 withType:0];
			[self addBlockWithX:240 withY:95 withType:0];
			[self addBlockWithX:205 withY:95 withType:0];
			[self addBlockWithX:275 withY:95 withType:0];
			[self addBlockWithX:38 withY:231 withType:1];
			[self addBlockWithX:104 withY:231 withType:1];
			[self addBlockWithX:170 withY:231 withType:1];
			[self addBlockWithX:236 withY:231 withType:1];
			[self addBlockWithX:302 withY:231 withType:1];
			[self addBlockWithX:368 withY:231 withType:1];
			[self addBlockWithX:434 withY:231 withType:1];
			
			goal = [[zGoal alloc] initWithCoords:ccp(420,25)];
			
			self.hintLocation = ccp(51,113);
			break;
		case 2:
			//load level 2
			[self addSpringWithX:0 withY:0 withType:0];
			[self addSpringWithX:420 withY:0 withType:6];
			
			[self addBlockWithX:240 withY:50 withType:1];
			[self addBlockWithX:240 withY:113 withType:2];
			[self addBlockWithX:205 withY:25 withType:0];
			[self addBlockWithX:275 withY:25 withType:0];
			[self addBlockWithX:121 withY:261 withType:0];
			[self addBlockWithX:156 withY:261 withType:0];
			[self addBlockWithX:321 withY:261 withType:0];
			[self addBlockWithX:355 withY:261 withType:0];
			
			//goal = [[zGoal alloc] initWithCoords:ccp(240,160)];
			goal = [[zGoal alloc] initWithCoords:ccp(269,117)];
			
			self.hintLocation = ccp(37,149);
			break;
		case 3:
			//load level 3
			[self addSpringWithX:0 withY:0 withType:0];
			[self addSpringWithX:400 withY:231 withType:10];
			[self addSpringWithX:339 withY:13 withType:8];
			
			[self addBlockWithX:180 withY:130 withType:1];
			[self addBlockWithX:245 withY:130 withType:1];
			[self addBlockWithX:310 withY:130 withType:1];
			[self addBlockWithX:150 withY:25 withType:2];
			[self addBlockWithX:150 withY:92 withType:2];
			[self addBlockWithX:390 withY:25 withType:0];
			[self addBlockWithX:425 withY:60 withType:0];
			[self addBlockWithX:460 withY:95 withType:0];
			[self addBlockWithX:20 withY:300 withType:0];
			[self addBlockWithX:55 withY:300 withType:0];
			[self addBlockWithX:90 withY:300 withType:0];
			
			goal = [[zGoal alloc] initWithCoords:ccp(213,50)];
			
			self.hintLocation = ccp(31,191);
			break;
		case 4:
			//load level 4
			[self addSpringWithX:0 withY:0 withType:0];
			[self addSpringWithX:300 withY:75 withType:4];
			[self addSpringWithX:420 withY:0 withType:6];
			
			[self addBlockWithX:240 withY:35 withType:2];
			[self addBlockWithX:240 withY:85 withType:2];
			[self addBlockWithX:240 withY:150 withType:2];
			[self addBlockWithX:240 withY:280 withType:2];
			
			goal = [[zGoal alloc] initWithCoords:ccp(300,300)];
			
			self.hintLocation = ccp(31,186);
			break;
		case 5:
			//previous level 14
			[self addBlockWithX:231 withY:286 withType:2];
			[self addBlockWithX:231 withY:220 withType:2];
			[self addBlockWithX:203 withY:181 withType:1];
			[self addBlockWithX:137 withY:181 withType:1];
			[self addBlockWithX:269 withY:181 withType:1];
			[self addBlockWithX:335 withY:181 withType:1];
			[self addBlockWithX:137 withY:115 withType:1];
			[self addBlockWithX:203 withY:115 withType:1];
			[self addBlockWithX:269 withY:115 withType:1];
			[self addBlockWithX:335 withY:115 withType:1];
			[self addBlockWithX:269 withY:50 withType:1];
			[self addBlockWithX:203 withY:50 withType:1];
			[self addBlockWithX:372 withY:147 withType:2];
			[self addBlockWithX:101 withY:147 withType:2];
			[self addBlockWithX:307 withY:20 withType:2];
			[self addBlockWithX:165 withY:20 withType:2];
			
			[self addSpringWithX:240 withY:191 withType:0];
			[self addSpringWithX:422 withY:5 withType:7];
			[self addSpringWithX:13 withY:0 withType:0];
			[self addSpringWithX:8 withY:260 withType:4];
			
			goal = [[zGoal alloc] initWithCoords:ccp(190,220)];
			
			self.hintLocation = ccp(267,285);
			break;
		case 6:
			//prevously level 5
			[self addSpringWithX:0 withY:0 withType:0];
			[self addSpringWithX:250 withY:131 withType:8];
			[self addSpringWithX:368 withY:0 withType:8];
			[self addSpringWithX:10 withY:220 withType:2];
			
			[self addBlockWithX:40 withY:200 withType:1];
			[self addBlockWithX:113 withY:200 withType:1];
			[self addBlockWithX:320 withY:200 withType:1];
			[self addBlockWithX:265 withY:113 withType:0];
			[self addBlockWithX:265 withY:79 withType:0];
			
			goal = [[zGoal alloc] initWithCoords:ccp(445,20)];
			
			self.hintLocation = ccp(371,194);
			break;
		case 7:
			[self addSpringWithX:123 withY:2 withType:1];
			[self addSpringWithX:8 withY:245 withType:3];
			[self addSpringWithX:180 withY:166 withType:6];
			[self addSpringWithX:380 withY:0 withType:7];
			[self addSpringWithX:255 withY:263 withType:4];
			
			[self addBlockWithX:250 withY:197 withType:2];
			[self addBlockWithX:250 withY:263 withType:2];
			[self addBlockWithX:20 withY:20 withType:0];
			[self addBlockWithX:55 withY:20 withType:0];
			[self addBlockWithX:90 withY:20 withType:0];
			[self addBlockWithX:20 withY:55 withType:0];
			[self addBlockWithX:55 withY:55 withType:0];
			[self addBlockWithX:90 withY:55 withType:0];
			[self addBlockWithX:460 withY:300 withType:0];
			[self addBlockWithX:425 withY:300 withType:0];
			[self addBlockWithX:460 withY:265 withType:0];
			[self addBlockWithX:425 withY:265 withType:0];
			[self addBlockWithX:460 withY:230 withType:0];
			[self addBlockWithX:425 withY:230 withType:0];
			
			goal = [[zGoal alloc ] initWithCoords:ccp(448,25)];
			
			self.hintLocation = ccp(189,233);
			break;
		case 8:
			[self addSpringWithX:10 withY:0 withType:1];
			[self addSpringWithX:240 withY:150 withType:8];
			[self addSpringWithX:170 withY:120 withType:2];
			[self addSpringWithX:303 withY:5 withType:6];
			[self addSpringWithX:345 withY:250 withType:3];
			[self addSpringWithX:375 withY:120 withType:8];
			[self addSpringWithX:461 withY:0 withType:8];
			
			[self addBlockWithX:100 withY:90 withType:1];
			[self addBlockWithX:166 withY:90 withType:1];
			[self addBlockWithX:232 withY:90 withType:1];
			[self addBlockWithX:70 withY:130 withType:2];
			[self addBlockWithX:70 withY:196 withType:2];
			[self addBlockWithX:100 withY:210 withType:0];
			[self addBlockWithX:135 withY:210 withType:0];
			[self addBlockWithX:100 withY:175 withType:0];
			[self addBlockWithX:135 withY:175 withType:0];
			[self addBlockWithX:100 withY:140 withType:0];
			[self addBlockWithX:135 withY:140 withType:0];
			[self addBlockWithX:250 withY:125 withType:0];
			[self addBlockWithX:291 withY:267 withType:0];
			[self addBlockWithX:291 withY:302 withType:0];
			[self addBlockWithX:291 withY:232 withType:0];
			[self addBlockWithX:390 withY:57 withType:0];
			[self addBlockWithX:390 withY:92 withType:0];
			
			goal = [[zGoal alloc ] initWithCoords:ccp(390,22)];
			
			self.hintLocation = ccp(231,284);
			break;
		case 9:
			[self addSpringWithX:431 withY:0 withType:7];
			[self addSpringWithX:201 withY:0 withType:2];
			[self addSpringWithX:275 withY:161 withType:1];
			[self addSpringWithX:440 withY:191 withType:8];
			[self addSpringWithX:0 withY:191 withType:4];
			[self addSpringWithX:160 withY:200 withType:9];
			
			[self addBlockWithX:200 withY:105 withType:2];
			[self addBlockWithX:200 withY:175 withType:2];
			[self addBlockWithX:200 withY:245 withType:2];
			[self addBlockWithX:270 withY:105 withType:2];
			[self addBlockWithX:270 withY:175 withType:2];
			[self addBlockWithX:270 withY:245 withType:2];
			[self addBlockWithX:235 withY:275 withType:1];
			[self addBlockWithX:180 withY:25 withType:0];
			[self addBlockWithX:145 withY:25 withType:0];
			[self addBlockWithX:110 withY:25 withType:0];
			[self addBlockWithX:180 withY:60 withType:0];
			[self addBlockWithX:145 withY:60 withType:0];
			[self addBlockWithX:110 withY:60 withType:0];
			
			goal = [[zGoal alloc] initWithCoords:ccp(25,25)];
			
			self.hintLocation = ccp(231,221);
			break;
		case 10:
			[self addSpringWithX:280 withY:120 withType:7];
			[self addSpringWithX:150 withY:270 withType:5];
			[self addSpringWithX:448 withY:0 withType:8];
			[self addSpringWithX:20 withY:0 withType:0];
			[self addSpringWithX:50 withY:160 withType:6];
			[self addSpringWithX:0 withY:270 withType:3];
			
			[self addBlockWithX:150 withY:75 withType:0];
			[self addBlockWithX:185 withY:75 withType:0];
			[self addBlockWithX:220 withY:75 withType:0];
			[self addBlockWithX:255 withY:75 withType:0];
			[self addBlockWithX:290 withY:75 withType:0];
			[self addBlockWithX:325 withY:75 withType:0];
			[self addBlockWithX:360 withY:75 withType:0];
			[self addBlockWithX:395 withY:75 withType:0];
			[self addBlockWithX:395 withY:110 withType:0];
			[self addBlockWithX:395 withY:145 withType:0];
			[self addBlockWithX:395 withY:180 withType:0];
			[self addBlockWithX:395 withY:215 withType:0];
			[self addBlockWithX:395 withY:250 withType:0];
			[self addBlockWithX:395 withY:285 withType:0];
			[self addBlockWithX:150 withY:110 withType:0];
			[self addBlockWithX:150 withY:145 withType:0];
			[self addBlockWithX:150 withY:180 withType:0];
			
			goal = [[zGoal alloc] initWithCoords:ccp(213,131)];
			
			self.hintLocation = ccp(445,273);
			break;
		case 11:
			[self addSpringWithX:0 withY:87 withType:0];
			[self addSpringWithX:115 withY:197 withType:10];
			[self addSpringWithX:185 withY:197 withType:0];
			[self addSpringWithX:410 withY:0 withType:6];
			[self addSpringWithX:251 withY:165 withType:11];
			[self addSpringWithX:185 withY:165 withType:5];
			[self addSpringWithX:0 withY:0 withType:3];
			
			[self addBlockWithX:290 withY:20 withType:0];
			[self addBlockWithX:270 withY:46 withType:1];
			[self addBlockWithX:235 withY:46 withType:1];
			[self addBlockWithX:335 withY:182 withType:0];
			[self addBlockWithX:370 withY:182 withType:0];
			[self addBlockWithX:335 withY:218 withType:0];
			[self addBlockWithX:370 withY:218 withType:0];
			
			goal = [[zGoal alloc] initWithCoords:ccp(240,20)];
			
			self.hintLocation = ccp(33,241);
			break;
		case 12:
			[self addBlockWithX:457 withY:25 withType:0];
			[self addBlockWithX:422 withY:25 withType:0];
			[self addBlockWithX:387 withY:25 withType:0];
			[self addBlockWithX:387 withY:60 withType:0];
			[self addBlockWithX:387 withY:95 withType:0];
			[self addBlockWithX:455 withY:195 withType:1];
			[self addBlockWithX:389 withY:195 withType:1];
			[self addBlockWithX:323 withY:195 withType:1];
			[self addBlockWithX:5 withY:41 withType:2];
			[self addBlockWithX:41 withY:5 withType:1];
			
			[self addSpringWithX:410 withY:200 withType:6];
			[self addSpringWithX:225 withY:160 withType:11];
			[self addSpringWithX:113 withY:0 withType:6];
			[self addSpringWithX:0 withY:141 withType:3];
			[self addSpringWithX:300 withY:13 withType:6];
			[self addSpringWithX:291 withY:123 withType:3];
			
			goal = [[zGoal alloc] initWithCoords:ccp(440,75)];
			
			self.hintLocation = ccp(412,239);
			break;
		case 13:
			[self addBlockWithX:15 withY:190 withType:0];
			[self addBlockWithX:50 withY:190 withType:0];
			[self addBlockWithX:85 withY:190 withType:0];
			[self addBlockWithX:120 withY:190 withType:0];
			[self addBlockWithX:155 withY:190 withType:0];
			[self addBlockWithX:190 withY:190 withType:0];
			[self addBlockWithX:190 withY:150 withType:0];
			[self addBlockWithX:190 withY:110 withType:0];
			[self addBlockWithX:190 withY:70 withType:0];
			[self addBlockWithX:155 withY:70 withType:0];
			[self addBlockWithX:120 withY:70 withType:0];
			[self addBlockWithX:320 withY:190 withType:0];
			[self addBlockWithX:320 withY:226 withType:0];
			[self addBlockWithX:320 withY:262 withType:0];
			[self addBlockWithX:320 withY:298 withType:0];
			[self addBlockWithX:355 withY:298 withType:0];
			
			[self addSpringWithX:2 withY:210 withType:0];
			[self addSpringWithX:270 withY:40 withType:0];
			[self addSpringWithX:387 withY:290 withType:5];
			[self addSpringWithX:0 withY:0 withType:0];
			[self addSpringWithX:2 withY:107 withType:3];
			[self addSpringWithX:448 withY:0 withType:8];
			
			goal = [[zGoal alloc] initWithCoords:ccp(145,131)];
			
			self.hintLocation = ccp(47,278);
			break;
		case 14:
			[self addSpringWithX:320 withY:235 withType:2];
			[self addSpringWithX:352 withY:165 withType:2];
			[self addSpringWithX:426 withY:0 withType:7];
			[self addSpringWithX:0 withY:172 withType:3];
			[self addSpringWithX:240 withY:0 withType:6];
			[self addSpringWithX:167 withY:271 withType:10];
			
			[self addBlockWithX:33 withY:247 withType:1];
			[self addBlockWithX:99 withY:247 withType:1];
			[self addBlockWithX:20 withY:20 withType:0];
			[self addBlockWithX:55 withY:20 withType:0];
			[self addBlockWithX:20 withY:55 withType:0];
			[self addBlockWithX:55 withY:55 withType:0];
			[self addBlockWithX:20 withY:90 withType:0];
			[self addBlockWithX:55 withY:90 withType:0];
			[self addBlockWithX:285 withY:300 withType:0];
			[self addBlockWithX:250 withY:300 withType:0];
			[self addBlockWithX:285 withY:265 withType:0];
			[self addBlockWithX:250 withY:265 withType:0];
			[self addBlockWithX:285 withY:230 withType:0];
			[self addBlockWithX:250 withY:230 withType:0];
			[self addBlockWithX:285 withY:195 withType:0];
			[self addBlockWithX:250 withY:195 withType:0];
			[self addBlockWithX:90 withY:20 withType:0];
			[self addBlockWithX:90 withY:55 withType:0];
			[self addBlockWithX:90 withY:90 withType:0];
			
			goal = [[zGoal alloc] initWithCoords:ccp(20,275)];
			
			self.hintLocation = ccp(343,275);
			break;
		case 15:
			[self addBlockWithX:198 withY:91 withType:1];
			[self addBlockWithX:264 withY:91 withType:1];
			[self addBlockWithX:181 withY:113 withType:0];
			[self addBlockWithX:280 withY:113 withType:0];
			[self addBlockWithX:181 withY:148 withType:0];
			[self addBlockWithX:280 withY:148 withType:0];
			[self addBlockWithX:131 withY:139 withType:1];
			[self addBlockWithX:113 withY:113 withType:0];
			[self addBlockWithX:146 withY:113 withType:0];
			[self addBlockWithX:315 withY:113 withType:0];
			[self addBlockWithX:350 withY:113 withType:0];
			[self addBlockWithX:333 withY:139 withType:1];
			
			[self addSpringWithX:420 withY:1 withType:7];
			[self addSpringWithX:21 withY:0 withType:2];
			[self addSpringWithX:420 withY:180 withType:6];
			[self addSpringWithX:50 withY:145 withType:0];
			[self addSpringWithX:113 withY:280 withType:10];
			
			goal = [[zGoal alloc] initWithCoords:ccp(230,125)];
			
			self.hintLocation = ccp(421,275);
			break;
		case 16:
			//previously 19
			[self addBlockWithX:20 withY:280 withType:0];
			[self addBlockWithX:131 withY:20 withType:0];
			[self addBlockWithX:20 withY:239 withType:0];
			[self addBlockWithX:55 withY:239 withType:0];
			[self addBlockWithX:90 withY:239 withType:0];
			[self addBlockWithX:455 withY:20 withType:0];
			[self addBlockWithX:20 withY:204 withType:0];
			[self addBlockWithX:55 withY:204 withType:0];
			[self addBlockWithX:10 withY:152 withType:2];
			
			[self addSpringWithX:45 withY:261 withType:0];
			[self addSpringWithX:115 withY:226 withType:0];
			[self addSpringWithX:295 withY:0 withType:0];
			[self addSpringWithX:347 withY:127 withType:6];
			[self addSpringWithX:213 withY:0 withType:6];
			[self addSpringWithX:-9 withY:-9 withType:2];
			[self addSpringWithX:79 withY:44 withType:1];
			[self addSpringWithX:129 withY:170 withType:10];
			
			goal = [[zGoal alloc] initWithCoords:ccp(77,20)];
			
			self.hintLocation = ccp(77,281);
			break;
		case 17:
			[self addBlockWithX:250 withY:255 withType:0];
			[self addBlockWithX:250 withY:220 withType:0];
			[self addBlockWithX:250 withY:185 withType:0];
			[self addBlockWithX:215 withY:185 withType:0];
			[self addBlockWithX:180 withY:185 withType:0];
			[self addBlockWithX:145 withY:185 withType:0];
			[self addBlockWithX:145 withY:150 withType:0];
			[self addBlockWithX:35 withY:127 withType:1];
			[self addBlockWithX:101 withY:127 withType:1];
			
			[self addSpringWithX:0 withY:131 withType:0];
			[self addSpringWithX:450 withY:0 withType:8];
			[self addSpringWithX:262 withY:0 withType:0];
			[self addSpringWithX:164 withY:135 withType:5];
			[self addSpringWithX:180 withY:0 withType:6];
			[self addSpringWithX:0 withY:90 withType:5];
			[self addSpringWithX:97 withY:-23 withType:2];
			
			goal = [[zGoal alloc] initWithCoords:ccp(20,20)];
			
			self.hintLocation = ccp(43,252);
			break;
		case 18:
			[self addBlockWithX:464 withY:75 withType:0];
			[self addBlockWithX:429 withY:75 withType:0];
			[self addBlockWithX:396 withY:75 withType:0];
			[self addBlockWithX:361 withY:75 withType:0];
			[self addBlockWithX:299 withY:178 withType:0];
			[self addBlockWithX:156 withY:231 withType:0];
			[self addBlockWithX:121 withY:231 withType:0];
			[self addBlockWithX:156 withY:267 withType:0];
			[self addBlockWithX:121 withY:267 withType:0];
			[self addBlockWithX:446 withY:231 withType:0];
			[self addBlockWithX:411 withY:231 withType:0];
			[self addBlockWithX:446 withY:267 withType:0];
			[self addBlockWithX:411 withY:267 withType:0];
			
			[self addSpringWithX:2 withY:240 withType:2];
			[self addSpringWithX:34 withY:176 withType:2];
			[self addSpringWithX:66 withY:112 withType:2];
			[self addSpringWithX:98 withY:48 withType:2];
			[self addSpringWithX:113 withY:0 withType:0];
			[self addSpringWithX:419 withY:110 withType:8];
			[self addSpringWithX:204 withY:290 withType:5];
			[self addSpringWithX:256 withY:0 withType:6];
			[self addSpringWithX:132 withY:145 withType:4];
			
			goal = [[zGoal alloc] initWithCoords:ccp(457,20)];
			
			self.hintLocation = ccp(33,271);
			break;
		case 19:
			//previously 16
			[self addBlockWithX:21 withY:205 withType:0];
			[self addBlockWithX:91 withY:170 withType:0];
			[self addBlockWithX:91 withY:135 withType:0];
			[self addBlockWithX:56 withY:205 withType:0];
			[self addBlockWithX:91 withY:100 withType:0];
			[self addBlockWithX:91 withY:205 withType:0];
			[self addBlockWithX:140 withY:215 withType:1];
			
			[self addSpringWithX:0 withY:222 withType:0];
			[self addSpringWithX:283 withY:67 withType:0];
			[self addSpringWithX:381 withY:213 withType:5];
			[self addSpringWithX:448 withY:0 withType:8];
			[self addSpringWithX:191 withY:0 withType:0];
			[self addSpringWithX:113 withY:178 withType:5];
			[self addSpringWithX:151 withY:0 withType:8];
			[self addSpringWithX:0 withY:-10 withType:0];
			
			goal = [[zGoal alloc] initWithCoords:ccp(21,160)];
			
			self.hintLocation = ccp(57,279);
			break;
		case 20:
			[self addSpringWithX:60 withY:73 withType:1];
			[self addSpringWithX:347 withY:230 withType:6];
			[self addSpringWithX:411 withY:263 withType:6];
			[self addSpringWithX:283 withY:197 withType:6];
			[self addSpringWithX:100 withY:0 withType:2];
			[self addSpringWithX:437 withY:0 withType:8];
			[self addSpringWithX:66 withY:249 withType:5];
	
			[self addBlockWithX:445 withY:191 withType:1];
			[self addBlockWithX:445 withY:131 withType:1];
			[self addBlockWithX:379 withY:191 withType:1];
			[self addBlockWithX:379 withY:131 withType:1];
			[self addBlockWithX:55 withY:226 withType:2];
			[self addBlockWithX:55 withY:160 withType:2];
			
			goal = [[zGoal alloc] initWithCoords:ccp(445,160)];
			
			self.hintLocation = ccp(423,282);
			break;
		case 21:
			[self addSpringWithX:121 withY:0 withType:6];
			[self addSpringWithX:75 withY:171 withType:6];
			[self addSpringWithX:13 withY:255 withType:3];
			[self addSpringWithX:455 withY:0 withType:9];
			[self addSpringWithX:213 withY:0 withType:2];
			[self addSpringWithX:449 withY:131 withType:8];
			[self addSpringWithX:375 withY:273 withType:10];
			
			[self addBlockWithX:203 withY:33 withType:2];
			[self addBlockWithX:203 withY:99 withType:2];
			[self addBlockWithX:203 withY:288 withType:2];
			[self addBlockWithX:20 withY:20 withType:0];
			[self addBlockWithX:55 withY:20 withType:0];
			[self addBlockWithX:55 withY:55 withType:0];
			[self addBlockWithX:20 withY:55 withType:0];
			[self addBlockWithX:236 withY:252 withType:1];
			[self addBlockWithX:302 withY:252 withType:1];
			[self addBlockWithX:463 withY:99 withType:0];
			[self addBlockWithX:428 withY:99 withType:0];
			[self addBlockWithX:445 withY:124 withType:1];
			[self addBlockWithX:445 withY:73 withType:1];
			[self addBlockWithX:460 withY:300 withType:0];
			[self addBlockWithX:460 withY:265 withType:0];
			
			goal = [[zGoal alloc] initWithCoords:ccp(233,285)];
			
			self.hintLocation = ccp(164,247);
			break;

		default:
			
			break;
	}
	
}

-(void)addSpringWithX:(int)theX withY:(int)theY withType:(int)theType
{
	zSpring *spring = [[zSpring alloc] initWithCoords:ccp(theX,theY) withSpringType:theType];
	[springs addObject:spring];
	[spring autorelease];
}

-(void)addBlockWithX:(int)theX withY:(int)theY withType:(int)theType
{
	zBlock *block = [[zBlock alloc] initWithCoords:ccp(theX,theY) blockType:theType];
	[blocks addObject:block];
	[block autorelease];
}

-(void)loadLevelBackground
{ 
	int rand = (arc4random() % 6)+1;
	NSString *randString = [NSString stringWithFormat:@"%i", rand];
	NSString *startString = @"bg_";
	NSString *midString = [startString stringByAppendingString:randString];
	NSString *finalString = [midString stringByAppendingString:@".png"];
	self.background = [[CCSprite alloc] initWithFile:finalString];
	[background autorelease];
	
}

- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	[springs release];
	[blocks release];
	[goal release];
	[balls release];
	[background release];
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
