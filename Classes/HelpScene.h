//
//  HelpScene.h
//  bounceZballs
//
//  Created by Steve Wight on 3/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface HelpScene : CCLayer {

}

+(id)scene;
-(id) init;
-(void) onBackButton:(id)sender;
-(void) generateGrassBackground;
-(void) displayHelpList;
-(NSString*) pickItemWithNumberInList:(int)numberInList;
-(void) displaySettings;

@end
