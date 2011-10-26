//
//  TheHouseThatWentOnStrikeViewController.h
//  TheHouseThatWentOnStrike
//
//  Created by Marilys Ernst on 10/5/11.
//  Copyright 2011 MI Artbox, Incorporated. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

#import "house_page.h";

#import "page01.h"
#import "page02.h"
#import "page03.h"
#import "page04.h"
#import "page05.h"
#import "page06.h"
#import "page07.h"
#import "page08.h"
#import "page09.h"
#import "page10.h"
#import "page11.h"
#import "page12.h"
#import "page13.h"
#import "page14.h"

#import "page15.h"
#import "page16.h"
#import "page17.h"
#import "page18.h"
#import "page19.h"

@class page01;
@class page02;
@class page03;

@class page04;
@class page05;
@class page06;
@class page07;
@class page08;
@class page09;
@class page10;
@class page11;
@class page12;
@class page13;
@class page14;
@class page15;
@class page16;
@class page17;
@class page18;
//@class page19;


@class credits_page;


@interface TheHouseThatWentOnStrikeViewController : UIViewController {
    
	//handles a call everytime the screen refreshes (like processing.org draw())
	//This triggers a function called 'update' in db_tabcustomViewController.m which in turn triggers the 'tick' 
	CADisplayLink *displayLink;
    
	//Actual pages. Should take care of themselves being loaded and destroyed. Recieves bump from display link
	house_page *pg01;
	house_page *pg02;
	house_page *pg03;
	house_page *pg04;
	
	house_page *pg05;	
	
	house_page *pg06;
	house_page *pg07;
	
	house_page *pg08;
	house_page *pg09;
	
	house_page *pg10;
	house_page *pg11;
	house_page *pg12;
	house_page *pg13;
	
	house_page *pg14;
	house_page *pg15;
	house_page *pg16;
	house_page *pg17;
	
	house_page *pg18;
	house_page *pg19;
	
	house_page *credits_pg;
    
	
	UIView * holder;
	UIImageView * masker;
    
	UIImageView * preloader;
	
	UIImageView* company_page;
    
	//Toggle state for menu on bottom
	BOOL showing_menu;
	
	//Toggle state for table of contents
	BOOL showing_toc;
	
	BOOL showing_company;
	
	//Int of current page. Useful for 'next' button. Could be referenced perhaps from the pages themselves.
	NSInteger current_page;
	NSInteger last_page; //this stores what was current page 
    
	//Holds current page. Can send calls to it if needed. For just using a tie through for display link
	house_page *currentViewController;
	
	//house_page *oldViewController;
    
	
	house_page *vcToOpen;
    
	//These variables are here to delay the request for a page long enough for it to take care of closing down
	int main_tag;
	int main_counter;
	int main_counter_last_request;
	BOOL requesting;
	
	//No longer being used
	IBOutlet UISlider *narrationSlider;  
	
	
	//These are the variables needed for handling the volume / mute settings for the narration
	IBOutlet UIButton *narrationTog; 
	float narrationVolume;
	float narrationVolume_max;
	BOOL narrationOn;
    
	//Volume and mute settings for the soundtrack. At some boing we'll bundle sfx in here too.
	IBOutlet UIButton *soundtrackTog; 
	float soundtrackVolume;
	float soundtrackVolume_max;
	BOOL soundtrackOn;
	
	//boolean for hints on/off
	BOOL hints_on;
	
	BOOL transitioning;
	
	SystemSoundID   page_turn_sound;
	SystemSoundID   preload_sound;
    
    
	CFURLRef        soundFileURLRef;
	
	UIButton* read_to_me;
	UIButton* read_myself;
	
	UIButton* refresh;
	UIButton* soundtrackButton;
	UIButton* narrationButton;
	UIButton* hintButton;
    
    NSString* language_suffix;
    
	BOOL refreshable;
    
}

@property (nonatomic, retain) IBOutlet UISlider *narrationSlider; //deprecated
@property (nonatomic, retain) IBOutlet UIButton *narrationTog; //Now they can be read/changed by the code and interface  
@property (nonatomic, retain) IBOutlet UIButton *soundtrackTog;  
@property (nonatomic, retain) IBOutlet UIButton *hintTog;  
@property (nonatomic, retain) IBOutlet UIButton *tocTog;  
@property (nonatomic, retain) IBOutlet UIButton *settingsTog;  
@property (nonatomic, retain) IBOutlet UIButton *languageTog;  
@property (nonatomic, retain) NSString *language_suffix;


@property (nonatomic, retain) IBOutlet UIButton *companyTog;  



@property (readonly) SystemSoundID   page_turn_sound;
@property (readonly) SystemSoundID   preload_sound;

@property (readwrite)   CFURLRef        soundFileURLRef;

/*
 Actions called by the button from the xib 
 */
-(IBAction) gotoWithSender:(id)sender;
-(IBAction) showMenu;
-(IBAction) showTOC;

-(IBAction) narrationToggle:(id)sender;
-(IBAction) soundtrackToggle:(id)sender;
-(IBAction) hintToggle:(id)sender;
-(IBAction) show_menu_from:(id)sender;
-(IBAction) linkToCompany:(id)sender;


- (void) pageOpenView:(house_page *) viewControllerToOpen direction:(BOOL)curl;

-(void)hideMenu;
-(void)gotoPage:(NSInteger)tag_to_use;

-(void)hideMenuQuick;
-(void)setupPreloader;
-(void)menuHighest;
-(void)menuMid;

-(void)menuSettingsHeight;
-(void)hideTOC;

/*hmmmmm pages need this for getters and setters?*/

/*
 @property (nonatomic, retain) page01 *pg01;
 @property (nonatomic, retain) page02 *pg02;
 @property (nonatomic, retain) page03 *pg03;
 @property (nonatomic, retain) page04 *pg04;
 @property (nonatomic, retain) page05a *pg05a;
 @property (nonatomic, retain) page05b *pg05b;
 @property (nonatomic, retain) page06 *pg06;
 @property (nonatomic, retain) page07 *pg07;
 @property (nonatomic, retain) page08 *pg08;
 @property (nonatomic, retain) page09 *pg09;
 @property (nonatomic, retain) page10 *pg10;
 @property (nonatomic, retain) page11 *pg11;
 @property (nonatomic, retain) page12 *pg12;
 @property (nonatomic, retain) page13a *pg13a;
 @property (nonatomic, retain) page14 *pg14;
 @property (nonatomic, retain) page15 *pg15;
 @property (nonatomic, retain) page16 *pg16;
 @property (nonatomic, retain) page17 *pg17;
 @property (nonatomic, retain) page18 *pg18;
 @property (nonatomic, retain) page19 *pg19;
 @property (nonatomic, retain) credits_page *credits_pg;
 */


@property (nonatomic, assign) UIViewController *currentViewController;

//@property (nonatomic, assign) UIViewController *oldViewController;


@end