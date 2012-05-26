//
//  MenuScene.h
//  bounceZballs
//
//  Created by Steve Wight on 2/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "zCloud.h"

@interface MenuScene : CCLayer {
	
}

+(id)scene;

-(void) addCloud:(zCloud*)cloud;
-(void) cloudMoveFinished:(id)sender;
-(void)cloudLogic:(ccTime)dt;
-(void)generateGrassBackground;
-(void) generateBall;

@end
