//
//  HowToScene.h
//  bounceZballs
//
//  Created by Steve Wight on 2/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface HowToScene : CCLayer {
	int sceneNumber;
	CCSprite *headerImage;
	CCSprite *sceneImage;
	CCLabelTTF *explanationLabel;
}
@property (nonatomic, assign)int sceneNumber;
@property (nonatomic, retain)CCSprite *headerImage;
@property (nonatomic, retain)CCSprite *sceneImage;
@property (nonatomic, retain)CCLabelTTF *explanationLabel;

+(id)scene;

-(id)initWithScene:(int)scene;
-(void)loadSceneInfo;
-(void)loadMenuButton;

-(void)onNext:(id)sender;
-(void)onMainMenu:(id)sender;

-(void) playButtonSound;

@end
