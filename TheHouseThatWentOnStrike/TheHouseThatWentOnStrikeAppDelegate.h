//
//  TheHouseThatWentOnStrikeAppDelegate.h
//  TheHouseThatWentOnStrike
//
//  Created by Marilys Ernst on 10/5/11.
//  Copyright 2011 MI Artbox, Incorporated. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TheHouseThatWentOnStrikeViewController;

@interface TheHouseThatWentOnStrikeAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet TheHouseThatWentOnStrikeViewController *viewController;

@end
