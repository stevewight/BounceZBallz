//
//  ResetLevelConfirmation.h
//  bounceZballs
//
//  Created by Steve Wight on 3/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface ResetLevelConfirmation : CCLayer {
	BOOL isFromWinScene;
}
@property(nonatomic,assign)BOOL isFromWinScene;

-(id) initWithIsWinScene:(BOOL)isWinScene;
+(id) scene;
-(void) displayMenu;
-(void) onYes:(id)sender;
-(void) onNo:(id)sender;

@end
