//
//  bounceZballsAppDelegate.h
//  bounceZballs
//
//  Created by Steve Wight on 2/5/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface bounceZballsAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

-(void) preLoadSoundEffects;

@end
