//
//  zThing.h
//  bounceZballs
//
//  Created by Steve Wight on 2/5/11.
//  Copyright 2011 __ZiatoGroup__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"

@interface zThing : CCNode {
	CGPoint coords;
	CCSprite *sprite;
}

@property(nonatomic, assign) CGPoint coords;
@property(nonatomic, retain) CCSprite *sprite;

-(id)init;

@end
