//
//  zTutorial.h
//  bounceZballs
//
//  Created by Steve Wight on 3/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface zTutorial : NSObject {
	int tutorialLevel;
	NSMutableArray *hints;
}
@property(nonatomic,assign)int tutorialLevel;
@property(nonatomic,retain)NSMutableArray *hints;

-(id) initWithLevel:(int)tutLevel;
-(NSMutableArray*) getTutorialHints;

@end
