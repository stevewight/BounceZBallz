//
//  zBlock.h
//  bounceZballs
//
//  Created by Steve Wight on 2/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "zThing.h"


@interface zBlock : zThing {
	int blockType;
}
@property(nonatomic,assign)int blockType;

-(id)initWithCoords:(CGPoint)p blockType:(int)bt;
-(NSString*) loadSpriteFileString;

@end
