//
//  zCloud.h
//  bounceZballs
//
//  Created by Steve Wight on 2/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "zThing.h"

@interface zCloud : zThing {

	int speedDuration;
	int zIndex;
}
@property (nonatomic, assign)int speedDuration;
@property (nonatomic, assign)int zIndex;

-(id)init;
-(NSString*) loadCloudFileName;
-(void) loadSpeedDuration;
-(void) loadCloudZIndex;
-(void) loadCloudPosition;

@end
