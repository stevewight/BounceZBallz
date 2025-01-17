//
//  AboutScene.h
//  bounceZballs
//
//  Created by Steve Wight on 2/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "zCloud.h"

@interface AboutScene : CCLayer {

}
+(id)scene;

-(id) init;

-(void) onBackButton:(id)sender;
-(void) onHelpButton:(id)sender;
-(void) addCloud:(zCloud*)cloud;
-(void) cloudMoveFinished:(id)sender;
-(void)cloudLogic:(ccTime)dt;
-(void) generateGrassBackground;

@end
