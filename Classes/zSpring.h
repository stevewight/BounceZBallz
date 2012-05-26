//
//  zSpring.h
//  bounceZballs
//
//  Created by Steve Wight on 2/6/11.
//  Copyright 2011 __ZiatoGroup__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "zThing.h"


@interface zSpring : zThing {
	int springType;
	NSString *spriteFileName;
}
@property(nonatomic, assign)int springType;
@property(nonatomic, retain)NSString *spriteFileName;

-(id)initWithCoords:(CGPoint)p withSpringType:(int)st;
-(NSString*) loadImageFileName;

@end
