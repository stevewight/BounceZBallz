//
//  zBall.h
//  bounceZballs
//
//  Created by Steve Wight on 2/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "zThing.h"
#import "zSpring.h"


@interface zBall : zThing {
	NSMutableSet *contactSprings;
	zSpring *lastSpringHit;
	int repeatSpringHit;
	
}
@property (nonatomic, retain)NSMutableSet *contactSprings;
@property (nonatomic, retain)zSpring *lastSpringHit;
@property (nonatomic, assign)int repeatSpringHit;

-(id)initWithCoords:(CGPoint)p;
-(void) addContactSpring:(zSpring*)contactSpring;

@end
