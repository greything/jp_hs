//
//  TheHouseThatWentOnStrikeViewController.m
//  TheHouseThatWentOnStrike
//
//  Created by Marilys Ernst on 10/5/11.
//  Copyright 2011 MI Artbox, Incorporated. All rights reserved.
//

#import "TheHouseThatWentOnStrikeViewController.h"

@implementation TheHouseThatWentOnStrikeViewController


@synthesize narrationSlider;
@synthesize narrationTog;
@synthesize soundtrackTog;
@synthesize hintTog;
@synthesize tocTog;
@synthesize languageTog;

@synthesize companyTog;
@synthesize settingsTog;

@synthesize preload_sound;

@synthesize page_turn_sound;
@synthesize soundFileURLRef;

@synthesize language_suffix;

@synthesize currentViewController;



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
    NSLog(@"View Did Load on primaryViewController");
    
	[self hideMenuQuick];
	
	//[self menuHighest];
    
	displayLink = [CADisplayLink displayLinkWithTarget:self 
											  selector:@selector(update:)]; [displayLink addToRunLoop:[NSRunLoop mainRunLoop] 
																							  forMode:NSRunLoopCommonModes];
	[displayLink setFrameInterval:1];
    
    //Chosing a language
    
#ifdef DGSPECIAL //if special version
    language_suffix = @"DE_Narration";
#endif
    
#ifndef DGSPECIAL //if normal version
    language_suffix = @"english";
#endif
	
    //language_suffix = @"DE_Narration";
    
    

    
	[self setupPreloader];
    
    [super viewDidLoad];
}


-(void) setupPreloader{
    NSLog(@"Set up preloader");

	NSURL *tempURL   = [[NSBundle mainBundle] URLForResource: @"P00_PageTurn" withExtension: @"wav"];
    self.soundFileURLRef = (CFURLRef) [tempURL retain];
    AudioServicesCreateSystemSoundID (soundFileURLRef,&page_turn_sound);
	
	tempURL   = [[NSBundle mainBundle] URLForResource: @"jp_ipad_open" withExtension: @"wav"];
    self.soundFileURLRef = (CFURLRef) [tempURL retain];
    AudioServicesCreateSystemSoundID (soundFileURLRef,&preload_sound);
    
	preloader = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,1024,768)];
    
    preloader.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"JP_Open_51" ofType:@"jpg"]];
    
    
	preloader.backgroundColor = [UIColor clearColor];
	//preloader.tag = 321;
	[self.view addSubview:preloader];
    
	
	//preloader.center = CGPointMake(384,512);
	//preloader.transform = CGAffineTransformMakeRotation(-M_PI / 2.0);
    
	preloader.animationImages = [NSArray arrayWithObjects:  
								 
								 /*THird of frames, imageWithContentsOfFile*/
								 
								 
								 
								 
								 
								 [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"JP_Open_0" ofType:@"jpg"]],
								 [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"JP_Open_3" ofType:@"jpg"]],
								 [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"JP_Open_6" ofType:@"jpg"]],
								 [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"JP_Open_9" ofType:@"jpg"]],
								 [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"JP_Open_12" ofType:@"jpg"]],
								 [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"JP_Open_15" ofType:@"jpg"]],
								 [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"JP_Open_18" ofType:@"jpg"]],
								 [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"JP_Open_21" ofType:@"jpg"]],
								 [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"JP_Open_24" ofType:@"jpg"]],
								 [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"JP_Open_27" ofType:@"jpg"]],
								 [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"JP_Open_30" ofType:@"jpg"]],
								 [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"JP_Open_33" ofType:@"jpg"]],
								 [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"JP_Open_36" ofType:@"jpg"]],
								 [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"JP_Open_39" ofType:@"jpg"]],
								 [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"JP_Open_42" ofType:@"jpg"]],
								 [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"JP_Open_45" ofType:@"jpg"]],
								 [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"JP_Open_48" ofType:@"jpg"]],
								 [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"JP_Open_51" ofType:@"jpg"]],
                                 
                                 
								 /* Third of the Frames image named */
								 
								 
								 /*
                                  
                                  [UIImage imageNamed:@"JP_Open_0.jpg"],
                                  [UIImage imageNamed:@"JP_Open_3.jpg"],
                                  [UIImage imageNamed:@"JP_Open_6.jpg"],
                                  [UIImage imageNamed:@"JP_Open_9.jpg"],
                                  [UIImage imageNamed:@"JP_Open_12.jpg"],
                                  [UIImage imageNamed:@"JP_Open_15.jpg"],
                                  [UIImage imageNamed:@"JP_Open_18.jpg"],
                                  [UIImage imageNamed:@"JP_Open_21.jpg"],
                                  [UIImage imageNamed:@"JP_Open_24.jpg"],
                                  [UIImage imageNamed:@"JP_Open_27.jpg"],
                                  [UIImage imageNamed:@"JP_Open_30.jpg"],
                                  [UIImage imageNamed:@"JP_Open_33.jpg"],
                                  [UIImage imageNamed:@"JP_Open_36.jpg"],
                                  [UIImage imageNamed:@"JP_Open_39.jpg"],
                                  [UIImage imageNamed:@"JP_Open_42.jpg"],
                                  [UIImage imageNamed:@"JP_Open_45.jpg"],
                                  [UIImage imageNamed:@"JP_Open_48.jpg"],
                                  [UIImage imageNamed:@"JP_Open_51.jpg"],
                                  [UIImage imageNamed:@"JP_Open_54.jpg"],
                                  [UIImage imageNamed:@"JP_Open_57.jpg"],
                                  [UIImage imageNamed:@"JP_Open_60.jpg"],
                                  [UIImage imageNamed:@"JP_Open_63.jpg"],
                                  [UIImage imageNamed:@"JP_Open_66.jpg"],
                                  [UIImage imageNamed:@"JP_Open_69.jpg"],
                                  [UIImage imageNamed:@"JP_Open_72.jpg"],
                                  [UIImage imageNamed:@"JP_Open_75.jpg"],
                                  [UIImage imageNamed:@"JP_Open_78.jpg"],
                                  [UIImage imageNamed:@"JP_Open_81.jpg"],
                                  [UIImage imageNamed:@"JP_Open_84.jpg"],
                                  [UIImage imageNamed:@"JP_Open_87.jpg"],
                                  
                                  */
								 
								 /* Full Sequence */
								 /*
                                  [UIImage imageNamed:@"JP_Open_0.jpg"],
                                  [UIImage imageNamed:@"JP_Open_1.jpg"],
                                  [UIImage imageNamed:@"JP_Open_2.jpg"],
                                  [UIImage imageNamed:@"JP_Open_3.jpg"],
                                  [UIImage imageNamed:@"JP_Open_4.jpg"],
                                  [UIImage imageNamed:@"JP_Open_5.jpg"],
                                  [UIImage imageNamed:@"JP_Open_6.jpg"],
                                  [UIImage imageNamed:@"JP_Open_7.jpg"],
                                  [UIImage imageNamed:@"JP_Open_8.jpg"],
                                  [UIImage imageNamed:@"JP_Open_9.jpg"],
                                  [UIImage imageNamed:@"JP_Open_10.jpg"],
                                  [UIImage imageNamed:@"JP_Open_11.jpg"],
                                  [UIImage imageNamed:@"JP_Open_12.jpg"],
                                  [UIImage imageNamed:@"JP_Open_13.jpg"],
                                  [UIImage imageNamed:@"JP_Open_14.jpg"],
                                  [UIImage imageNamed:@"JP_Open_15.jpg"],
                                  [UIImage imageNamed:@"JP_Open_16.jpg"],
                                  [UIImage imageNamed:@"JP_Open_17.jpg"],
                                  [UIImage imageNamed:@"JP_Open_18.jpg"],
                                  [UIImage imageNamed:@"JP_Open_19.jpg"],
                                  [UIImage imageNamed:@"JP_Open_20.jpg"],
                                  [UIImage imageNamed:@"JP_Open_21.jpg"],
                                  [UIImage imageNamed:@"JP_Open_22.jpg"],
                                  [UIImage imageNamed:@"JP_Open_23.jpg"],
                                  [UIImage imageNamed:@"JP_Open_24.jpg"],
                                  [UIImage imageNamed:@"JP_Open_25.jpg"],
                                  [UIImage imageNamed:@"JP_Open_26.jpg"],
                                  [UIImage imageNamed:@"JP_Open_27.jpg"],
                                  [UIImage imageNamed:@"JP_Open_28.jpg"],
                                  [UIImage imageNamed:@"JP_Open_29.jpg"],
                                  [UIImage imageNamed:@"JP_Open_30.jpg"],
                                  [UIImage imageNamed:@"JP_Open_31.jpg"],
                                  [UIImage imageNamed:@"JP_Open_32.jpg"],
                                  [UIImage imageNamed:@"JP_Open_33.jpg"],
                                  [UIImage imageNamed:@"JP_Open_34.jpg"],
                                  [UIImage imageNamed:@"JP_Open_35.jpg"],
                                  [UIImage imageNamed:@"JP_Open_36.jpg"],
                                  [UIImage imageNamed:@"JP_Open_37.jpg"],
                                  [UIImage imageNamed:@"JP_Open_38.jpg"],
                                  [UIImage imageNamed:@"JP_Open_39.jpg"],
								  
                                  [UIImage imageNamed:@"JP_Open_40.jpg"],
                                  [UIImage imageNamed:@"JP_Open_41.jpg"],
                                  [UIImage imageNamed:@"JP_Open_42.jpg"],
                                  [UIImage imageNamed:@"JP_Open_43.jpg"],
                                  [UIImage imageNamed:@"JP_Open_44.jpg"],
                                  [UIImage imageNamed:@"JP_Open_45.jpg"],
                                  [UIImage imageNamed:@"JP_Open_46.jpg"],
                                  [UIImage imageNamed:@"JP_Open_47.jpg"],
                                  [UIImage imageNamed:@"JP_Open_48.jpg"],
                                  
                                  
                                  [UIImage imageNamed:@"JP_Open_49.jpg"],
                                  [UIImage imageNamed:@"JP_Open_50.jpg"],
                                  [UIImage imageNamed:@"JP_Open_51.jpg"],
                                  [UIImage imageNamed:@"JP_Open_52.jpg"],
                                  [UIImage imageNamed:@"JP_Open_53.jpg"],
                                  [UIImage imageNamed:@"JP_Open_54.jpg"],
                                  [UIImage imageNamed:@"JP_Open_55.jpg"],
                                  [UIImage imageNamed:@"JP_Open_56.jpg"],
                                  [UIImage imageNamed:@"JP_Open_57.jpg"],
                                  [UIImage imageNamed:@"JP_Open_58.jpg"],
                                  [UIImage imageNamed:@"JP_Open_59.jpg"],
                                  [UIImage imageNamed:@"JP_Open_60.jpg"],
                                  [UIImage imageNamed:@"JP_Open_61.jpg"],
                                  
                                  
                                  [UIImage imageNamed:@"JP_Open_62.jpg"],
                                  [UIImage imageNamed:@"JP_Open_63.jpg"],
                                  [UIImage imageNamed:@"JP_Open_64.jpg"],
                                  [UIImage imageNamed:@"JP_Open_65.jpg"],
                                  [UIImage imageNamed:@"JP_Open_66.jpg"],
                                  [UIImage imageNamed:@"JP_Open_67.jpg"],
                                  [UIImage imageNamed:@"JP_Open_68.jpg"],
                                  [UIImage imageNamed:@"JP_Open_69.jpg"],
                                  [UIImage imageNamed:@"JP_Open_70.jpg"],
                                  [UIImage imageNamed:@"JP_Open_71.jpg"],
                                  [UIImage imageNamed:@"JP_Open_72.jpg"],
                                  [UIImage imageNamed:@"JP_Open_73.jpg"],
                                  [UIImage imageNamed:@"JP_Open_74.jpg"],
                                  [UIImage imageNamed:@"JP_Open_75.jpg"],
                                  [UIImage imageNamed:@"JP_Open_76.jpg"],
                                  [UIImage imageNamed:@"JP_Open_77.jpg"],
                                  [UIImage imageNamed:@"JP_Open_78.jpg"],
                                  [UIImage imageNamed:@"JP_Open_79.jpg"],
                                  [UIImage imageNamed:@"JP_Open_80.jpg"],
                                  [UIImage imageNamed:@"JP_Open_81.jpg"],
                                  [UIImage imageNamed:@"JP_Open_82.jpg"],
                                  [UIImage imageNamed:@"JP_Open_83.jpg"],
                                  [UIImage imageNamed:@"JP_Open_84.jpg"],
                                  [UIImage imageNamed:@"JP_Open_85.jpg"],
                                  [UIImage imageNamed:@"JP_Open_86.jpg"],
                                  [UIImage imageNamed:@"JP_Open_87.jpg"],
                                  [UIImage imageNamed:@"JP_Open_88.jpg"],
                                  [UIImage imageNamed:@"JP_Open_89.jpg"],
                                  */
								 
								 nil];
	
	preloader.animationDuration = 1;
	preloader.animationRepeatCount = 1;
	[preloader startAnimating];
	[preloader release];
    
	
}


-(void) setupBook{
    NSLog(@"Set up book");

	
	showing_toc = NO;
	showing_company = NO;
	/*
	 Set the relative volumes. Max is 1
	 I suppose narationVolume_max should be 1 always and everything else may be less. 
	 Also we are going to add a volume setting for sfx and others. 
	 */
	narrationVolume_max = 1;
	soundtrackVolume_max = .4; 
	
	//Don't touch this part.
	narrationVolume = narrationVolume_max; 
	soundtrackVolume = soundtrackVolume_max;
	
	hints_on = YES;
	/*
	 
	 Displaylink calls every time the screen is going to refresh. It will poke update method (below)
	 
	 */
    
	
	
	/*Wipe menus quickly before showing them for the first time*/
	//[self showTOC];
	
	/*
	 Show menu with proper animation if needed 
	 */	
	
	/*
	 Load up the first page
	 */
	current_page = 0;	
	
	UIView* nav_settings_page = [[UIView alloc] initWithFrame:CGRectMake(0,0,1024,182)];
	[[self.view viewWithTag:123] addSubview:nav_settings_page];
	nav_settings_page.alpha = 0;
	nav_settings_page.backgroundColor = [UIColor clearColor];
	nav_settings_page.tag = 68;
	[nav_settings_page release];
	
	UIImageView* nav_language_page = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,1024,50)];
	[[self.view viewWithTag:123] addSubview:nav_language_page];
	nav_language_page.alpha = 0;
	//nav_language_page.backgroundColor = [UIColor clearColor];
	nav_language_page.image = [UIImage imageNamed:@"languages_soon.png"];
	nav_language_page.tag = 69;
	[nav_language_page release];
	
	CGPoint temp_center = CGPointMake(0, 20);
	
	soundtrackButton = [UIButton buttonWithType: UIButtonTypeCustom];
	soundtrackButton.frame = CGRectMake(251,0,65,65);
	soundtrackButton.center = CGPointMake(412, temp_center.y);
	
	[soundtrackButton setImage:[UIImage imageNamed:@"Nav_Music_on.png"] forState:UIControlStateNormal];
	[soundtrackButton setImage:[UIImage imageNamed:@"Nav_Music_off.png"] forState:UIControlStateSelected];
	[soundtrackButton setImage:[UIImage imageNamed:@"Nav_Music_off.png"] forState:UIControlStateHighlighted];
	
	[soundtrackButton addTarget:self action:@selector(soundtrackToggle:) forControlEvents:UIControlEventTouchUpInside];
	
	[[self.view viewWithTag:68] addSubview:soundtrackButton];
	
	narrationButton = [UIButton buttonWithType: UIButtonTypeCustom];
	narrationButton.frame = CGRectMake(351,0,65,65);
	narrationButton.center = CGPointMake(512, temp_center.y);
	[narrationButton setImage:[UIImage imageNamed:@"Nav_Narator_On.png"] forState:UIControlStateNormal];
	[narrationButton setImage:[UIImage imageNamed:@"Nav_Narator_Off.png"] forState:UIControlStateSelected];
	[narrationButton setImage:[UIImage imageNamed:@"Nav_Narator_Off.png"] forState:UIControlStateHighlighted];
	
	[narrationButton addTarget:self action:@selector(narrationToggle:) forControlEvents:UIControlEventTouchUpInside];
	
	[[self.view viewWithTag:68] addSubview:narrationButton];
	
	hintButton = [UIButton buttonWithType: UIButtonTypeCustom];
	hintButton.frame = CGRectMake(451,0,65,65);
	hintButton.center = CGPointMake(612, temp_center.y);
	[hintButton setImage:[UIImage imageNamed:@"Nav_Hints_On.png"] forState:UIControlStateNormal];
	[hintButton setImage:[UIImage imageNamed:@"Nav_Hints_Off.png"] forState:UIControlStateSelected];
	[hintButton setImage:[UIImage imageNamed:@"Nav_Hints_Off.png"] forState:UIControlStateHighlighted];
	
	[hintButton addTarget:self action:@selector(hintToggle:) forControlEvents:UIControlEventTouchUpInside];
	
	[[self.view viewWithTag:68] addSubview:hintButton];
	
	CGRect menu_frame = [[self.view viewWithTag:55] viewWithTag:66].frame;
	menu_frame.origin.y = 100;
	[[self.view viewWithTag:55] viewWithTag:66].frame = menu_frame;
	
	company_page = [[UIImageView alloc] initWithFrame:CGRectMake(0,-30,1024,182)];
	company_page.image = [UIImage imageNamed:@"marketingpage.png"];
	company_page.userInteractionEnabled = YES;
	[[self.view viewWithTag:123] addSubview:company_page];
	company_page.alpha = 0;
	company_page.tag = 67;
	[company_page release];
	
	UIButton* companyLinkButton = [UIButton buttonWithType: UIButtonTypeCustom];
	companyLinkButton.frame = CGRectMake(700,120,200,30);
	companyLinkButton.backgroundColor = [UIColor clearColor];
	[companyLinkButton addTarget:self action:@selector(linkToCompany:) forControlEvents:UIControlEventTouchUpInside];
	
	[company_page addSubview:companyLinkButton];
    
    
	
	/*
	 
	 This is deprecated perhaps. We will handle swipes differently. 
	 
	 // -----------------------------
	 // One finger, swipe left
	 // -----------------------------
	 UISwipeGestureRecognizer *oneFingerSwipeLeft = 
	 [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeLeft:)] autorelease];
	 [oneFingerSwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
	 [[self view] addGestureRecognizer:oneFingerSwipeLeft];
	 
	 // -----------------------------
	 // One finger, swipe right
	 // -----------------------------
	 UISwipeGestureRecognizer *oneFingerSwipeRight = 
	 [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeRight:)] autorelease];
	 [oneFingerSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
	 [[self view] addGestureRecognizer:oneFingerSwipeRight];
	 */
	
    
	
	holder = [[UIView alloc] initWithFrame:CGRectMake(0,0,1024,768)];
	[self.view insertSubview:holder belowSubview:[self.view viewWithTag:55]];
	
	
	masker = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,1024,768)];
	masker.tag = 555;
	[holder addSubview:masker];
	masker.image = [UIImage imageNamed:@"P01.png"];
	masker.hidden = YES;
	
	transitioning = NO;
	
	[self gotoPage:0];
	
	read_to_me = [UIButton buttonWithType: UIButtonTypeCustom];
	read_to_me.frame = CGRectMake(85,620,222,40);
	read_to_me.tag = 999;
	[read_to_me setImage:[UIImage imageNamed:@"Nav_ReadToMe.png"] forState:UIControlStateNormal];
	[read_to_me setImage:[UIImage imageNamed:@"Nav_ReadToMe_Act.png"] forState:UIControlStateSelected];
	[read_to_me setImage:[UIImage imageNamed:@"Nav_ReadToMe_Act.png"] forState:UIControlStateHighlighted];
	
	[read_to_me addTarget:self action:@selector(read_to_me_now:) forControlEvents:UIControlEventTouchUpInside];
	
	[self.view insertSubview:read_to_me belowSubview:[self.view viewWithTag:55]];
	
	
	read_myself = [UIButton buttonWithType: UIButtonTypeCustom];
	read_myself.frame = CGRectMake(680,620,280,40);
	read_myself.tag = 998;
	[read_myself setImage:[UIImage imageNamed:@"Nav_ReadItMyself.png"] forState:UIControlStateNormal];
	[read_myself setImage:[UIImage imageNamed:@"Nav_ReadItMyself_Act.png"] forState:UIControlStateSelected];
	[read_myself setImage:[UIImage imageNamed:@"Nav_ReadItMyself_Act.png"] forState:UIControlStateHighlighted ];
	
	[read_myself addTarget:self action:@selector(read_myself_now:) forControlEvents:UIControlEventTouchUpInside];
	
	[self.view insertSubview:read_myself belowSubview:[self.view viewWithTag:55]];
	
	refresh = [UIButton buttonWithType: UIButtonTypeCustom]; 
	refresh.frame = CGRectMake(920,712,43,43);
	[refresh setImage:[UIImage imageNamed:@"Nav_Refresh.png.png"] forState:UIControlStateNormal];
	[refresh setImage:[UIImage imageNamed:@"Nav_Reload.png"] forState:UIControlStateSelected];
	refresh.hidden = YES;
	refreshable = NO;
	[refresh addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:refresh];
	
	
	
}

-(void) refresh:(UIButton*)sender{
    
	refresh.hidden = YES;
	
	[self gotoPage:current_page];
	
}

-(void) read_to_me_now:(UIButton*)sender{
	
	NSLog(@"read_to_me_now");
	
	[self gotoWithSender:sender];
	
    
	NSLog(@"narration toggle");
    
	narrationOn = YES;
	narrationVolume = narrationVolume_max;
	narrationTog.selected = NO;
    
	[currentViewController setVolume:narrationVolume];
	
}

-(void) linkToCompany:(UIButton*)sender{
	
	NSLog(@"link outside");
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.jumpingpages.com"]];
    
	
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	/*
     for (UITouch *touch in touches) {
     NSArray *array = touch.gestureRecognizers;
     for (UIGestureRecognizer *gesture in array) {
     if (gesture.enabled && [gesture isMemberOfClass:[UIPinchGestureRecognizer class]]) {
     gesture.enabled = NO;
     }
     }
     }
     
     // get touch event
     UITouch *touch = [[event allTouches] anyObject];
     
     // get the touch location
     CGPoint touchLocation = [touch locationInView:self.view];
     
     NSLog(@"touches on %i", [[touch view] tag]);
     
     if([touch view] == company_page){
     
     NSLog(@"company page touched");
     
     }
     */
}

-(void) read_myself_now:(UIButton*)sender{
	
	narrationTog.selected = YES;
	narrationVolume = 0;
	narrationOn = NO;
	
	NSLog(@"read_myself_now");
	[self gotoWithSender:sender];
	
	[currentViewController setVolume:narrationVolume];
    
}

-(void) deselectButtons{
	
	companyTog.selected = NO;
	tocTog.selected = NO;
	settingsTog.selected = NO;
	languageTog.selected = NO;
	
}

-(void) show_menu_from:(UIButton*)sender{
	
	NSLog(@"Sender tag is: %i", sender.tag);
	
	//wipe insides of menu and reset buttons
	for (UIView *v in [[self.view viewWithTag:123] subviews]) {
		v.alpha = 0;
	}
    
	
	int viewTag = 0;
	
	//Company Page
	if(sender.tag == 1230){
		viewTag = 67;
        if(!companyTog.selected){
            [self menuHighest];
            [self deselectButtons];
            companyTog.selected = YES;
        }
        else{
            [self menuMid];
            [self deselectButtons];
        }
	}
	
	//Table of Contents
	if(sender.tag == 1231){
		viewTag = 66;
        if(!tocTog.selected){
            [self menuHighest];
            [self deselectButtons];
            [self.view viewWithTag:viewTag].frame = CGRectMake(0,0,1024,182);
            tocTog.selected = YES;
        }
        else{
            [self menuMid];
            [self deselectButtons];
        }
        
	}
	
	//Nav settings
	if(sender.tag == 1232){
		viewTag = 68;
        if(!settingsTog.selected){
            [self menuSettingsHeight];
            [self deselectButtons];
            [self.view viewWithTag:viewTag].frame = CGRectMake(0,0,1024,182);
            settingsTog.selected = YES;
        }
        else{
            [self menuMid];
            [self deselectButtons];
        }
        
	}
	
	//language settings
	if(sender.tag == 1233){
		viewTag = 69;
        if(!languageTog.selected){
            [self menuSettingsHeight];
            [self deselectButtons];
            [self.view viewWithTag:viewTag].frame = CGRectMake(0,0,1024,50);
            languageTog.selected = YES;
        }
        else{
            [self menuMid];
            [self deselectButtons];
        }
        
	}
	
	[self.view viewWithTag:viewTag].alpha = 1;
	[self.view bringSubviewToFront:[self.view viewWithTag:123]];
	[self.view bringSubviewToFront:[self.view viewWithTag:viewTag]];
	//showing_company = YES;
	
	
}
/*
 
 These narrationToggle and soundtrackToggle functions are what are called IBActions.
 They respond to messages from the interface. They make use of the '.selected' property of the interface buttons themselves 
 to know whether the audio parts are currently muted or unmuted. 
 
 */

- (IBAction)narrationToggle:(UIButton *)sender {  
    //NSLog(@"%f", sender.value);  
	
	//if(sender == narrationTog){
	
    NSLog(@"narration toggle");
    
    if(narrationButton.selected == NO){
        narrationButton.selected = YES;
        narrationVolume = 0;
        narrationOn = NO;
    }
    else {
        narrationOn = YES;
        narrationVolume = narrationVolume_max;
        narrationButton.selected = NO;
    }
    
	//}
	
	[currentViewController setVolume:narrationVolume];
}

- (IBAction)soundtrackToggle:(UIButton *)sender {  
    //NSLog(@"%f", sender.value);  
	
	//if(sender == soundtrackTog){
    
    NSLog(@"soundtrack toggle");
    
    if(soundtrackButton.selected == NO){
        soundtrackButton.selected = YES;
        soundtrackVolume = 0;
        soundtrackOn = NO;
    }
    else {
        soundtrackOn = YES;
        soundtrackVolume = soundtrackVolume_max;
        soundtrackButton.selected = NO;
    }
    
	//}
	
	[currentViewController setSoundtrackVolume:soundtrackVolume];
}

- (IBAction)hintToggle:(UIButton *)sender {  
    //NSLog(@"%f", sender.value);  
	
	//if(sender == hintTog){
    
    NSLog(@"hinttoggle");
    
    if(hintButton.selected == NO){
        hintButton.selected = YES;
        hints_on = NO;
    }
    else {
        hintButton.selected = NO;
        hints_on = YES;
    }
    
    [currentViewController setHints:hints_on];
    
	//}
	
}

/* 
 
 Showing/hiding menus section:
 
 Each of these methods does some animation to bring the menu views in and out of the screen. 
 They are designed to be able to be called redundantly 
 (for instance a call to 'hide menu' when the menu is already hidden will be ignored)
 
 */

-(void)showMenu{
	
	if(!showing_menu){
		[self menuMid];
		showing_menu = YES;
	}
	else{
		[self hideMenu];
	}
	
}

/*
 -(void)showCompany{
 
 NSLog(@"showing company");
 
 [self tocOff];
 
 if(!showing_company){
 
 [self companyOn];
 
 
 [self menuHighest];
 
 
 
 }
 else {
 
 [self menuMid];
 showing_company = NO;
 }
 
 }
 
 */

-(void)menuLowest{
    
    NSLog(@"Menu Lowest Called");

	CGRect screenRect = CGRectMake(0,0,1024, 768);
	CGFloat screenHeight = screenRect.size.height;
	CGRect menu_frame = [self.view viewWithTag:55].frame;
	menu_frame.origin.y = screenHeight - 24;
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationDelay:.5];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	
	[self.view viewWithTag:55].frame = menu_frame;
	
	[UIView commitAnimations];
	
}


-(void)menuMid{
	CGRect screenRect = CGRectMake(0,0,1024, 768);
	CGFloat screenHeight = screenRect.size.height;
	NSLog(@"show menu %f", screenHeight);
	CGRect menu_frame = [self.view viewWithTag:55].frame;
	menu_frame.origin.y = screenHeight - (menu_frame.size.height - 250);
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationDelay:0];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[self.view viewWithTag:55].frame = menu_frame;
	[UIView commitAnimations];
	
}

-(void)hideMenu{
    
    NSLog(@"hide menu");
    
	[self deselectButtons];
    
	[self menuLowest];
    
	showing_menu = NO;
	tocTog.selected = NO;
    
}

-(void)hideMenuQuick{
    NSLog(@"hide menu quick");

	[self menuLowest];
    
	showing_menu = NO;
	
}

-(void)tocOff{
	
	[[self.view viewWithTag:55] viewWithTag:66].alpha = 0;
	tocTog.selected = NO;
	showing_toc = NO;
}

-(void)tocOn{
	
	[[self.view viewWithTag:55] viewWithTag:66].alpha = 1;
	[[self.view viewWithTag:55] viewWithTag:66].frame = CGRectMake(0,90,1024,182);
    
	tocTog.selected = YES;
	showing_toc = YES;
}

-(void)companyOff{
	
	[[self.view viewWithTag:55] viewWithTag:67].alpha = 0;
	companyTog.selected = NO;
	showing_company = NO;
}

-(void)companyOn{
	
	[[self.view viewWithTag:55] viewWithTag:67].alpha = 1;
	companyTog.selected = YES;
	showing_company = YES;
	
}

-(void)showTOC{
	
	if(!showing_toc){
		
		[self companyOff];
        
		[self tocOn];
		
		[self menuHighest];
        
		showing_menu = YES;
        
	}
	else{
        
		//[self tocOff];
		[self hideTOC];
	}
    
}



-(void)menuHighest{
	
	CGRect screenRect = CGRectMake(0,0,1024, 768);
	CGFloat screenHeight = screenRect.size.height;
    
	CGRect menu_frame = [self.view viewWithTag:55].frame;
	
	menu_frame.origin.y = screenHeight - (menu_frame.size.height - 100);
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationDelay:0];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	
	[self.view viewWithTag:55].frame = menu_frame;
	[UIView commitAnimations];
	
}

-(void)menuSettingsHeight{
	
	CGRect screenRect = CGRectMake(0,0,1024, 768);
	CGFloat screenHeight = screenRect.size.height;
	
	CGRect menu_frame = [self.view viewWithTag:55].frame;
	
	menu_frame.origin.y = screenHeight - (menu_frame.size.height - 190);
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationDelay:0];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	
	[self.view viewWithTag:55].frame = menu_frame;
	[UIView commitAnimations];
	
}


-(void)hideTOC{
	
	if(showing_menu){
		[self menuMid];
		showing_toc = NO;
		showing_menu = NO;
	}
	//showing_menu = NO;
	
	//[self showMenu];
	
	else{
        CGRect menu_frame = [self.view viewWithTag:66].frame;
        menu_frame.origin.y = 300;
        [[self.view viewWithTag:55] viewWithTag:66].frame = menu_frame;
	}
	
	showing_toc = NO;
	
}

-(void)hideTOCQuick{
	
	CGRect menu_frame = [self.view viewWithTag:66].frame;
	menu_frame.origin.y = 300;
	[[self.view viewWithTag:55] viewWithTag:66].frame = menu_frame;
	showing_toc = NO;
	
}

//Beginning of Page Switching

-(void)gotoWithSender:(UIButton*)sender {
	
	if(!requesting){
		/*
         
		 This is the main page switching method. Called from buttons in the in xib. 
		 Their tags are tested with a switch statement.
		 As a result tags 0 - n for n pages are taken
		 
         */
		
		//Store the page that we will be leaving.	
		last_page = current_page;
        
		//# of pages in the book.	
		NSInteger max_page = 19;
		
		NSInteger tag_to_use = -10;//set to negative one to check if its been altered by next / previous page
        
		//Recieve the 'tag' value of the button from the interface. You will see 'tag' in the properties for buttons in interface builder.
		switch(sender.tag){
				
				/*
				 The left and right buttons have special tags: 99 for left, 100 for right. 
				 IF we were to make a book with more than 99 pages we would have to change these values.
				 */
				//previous_page
            case 99:
                current_page--;
                if (current_page < -1) {
                    //here is the end of the book.
                    current_page = -1;
                }
                tag_to_use = current_page;
                break;
                
				//next page
            case 100:
                current_page++;
                if (current_page > max_page) {
                    //here is the end of the book.
                    current_page = 0;
                }
                tag_to_use = current_page;
                break;
				
                //case for read to me	
			case 999:
				last_page = 0;
				tag_to_use = 1;
				current_page = 1;
				break;
				
                //case for ready to myself
			case 998:
				last_page = 0;
				tag_to_use = 1;
				current_page = 1;
				break;
		}
		
		BOOL dont_switch = (current_page == 0) && (sender.tag == 0);
		
		//if the tag has not been altered, just interpret the tag # as the page number. 
		if(tag_to_use == -10){
			tag_to_use = sender.tag;
			current_page = sender.tag;
		}
        
		NSLog(@"didSelectItem: %d", sender.tag);
		/*
		 
		 Here we set up the update method to act as a buffer for a few frames. 
		 The boolean 'requesting' lets the update method know to count until main_counter 
		 is significantly larger than main_counter_last_request
		 
		 */	
		
		
		if(!dont_switch){
			requesting = YES;
			main_counter_last_request = main_counter;
			main_tag = tag_to_use;
		}
	}//end of not requesting
    //upmask tells the page to take a screen grab of itself and put it on the top layer. 
    //[currentViewController upMask];
    
    //Hide the menu incase it is showing. 
    [self hideMenu];
	
    
}


/*
 
 gotoPage is the function that actually loads up new pages. It takes a number as in [self gotoPage:0] 
 Currently gotoPage is called by the 'update' function after gotoWithSender sets it in motion.
 See gotoWith Sender for more details. 
 
 */
-(void)gotoPage:(NSInteger)tag_to_use
{
	/*
	 Here we determine which direction the page animation should go 
	 */
	
	//why not assume we are moving backward	
	bool curlup = NO;
	
	//if the previous page is a lower number than the next page, we are moving forward, hence: curlup
	if(last_page < current_page){
		
		curlup = true;
        
	}
    
	//Hide table of contents... 					
	[self hideTOC];
    
	/*	
	 Switch statements are a simple way to make branching paths in the program. 
	 It evaluates tag_to_use (the page number to use) and will perform different actions depending on what it finds.
	 There is a lot of redundancy in this code. Could be improved for sure.  
	 */
	NSLog(@"gotoPage");
	
	masker.hidden = YES;
	
	if(tag_to_use <= 0){
		
		read_to_me.hidden = NO;
		read_myself.hidden = NO;	
		
	}
	else{
		
		read_to_me.hidden = YES;
		read_myself.hidden = YES;
		
	}
	
	if(tag_to_use != 0){
        
		AudioServicesPlaySystemSound (page_turn_sound);
        
		
	}
	
	
	switch (tag_to_use){
            
		case -1:
			
            
			//[self showTOC];
			//break;	
			
			
		case 0:
			
			/*
			 I'll just comment one page transition.
			 Every page should be doing the same thing. 
			 There is definitely room for improvement here.
			 */
			//Begin loading the page we are going to have next
			
			masker.image = [UIImage imageNamed:@"P01.png"];
            
			
			pg01 = [page01 alloc];
			[self pageOpenView:pg01 direction:curlup];	
			//[pg01 autorelease];
            
			break;		
			
		case 1:
			masker.image = [UIImage imageNamed:@"P02.png"];
            
			pg02 = [page02 alloc];
			[self pageOpenView:pg02 direction:curlup];
			//[pg02 autorelease];
            
			break;	
			
		case 2:
			masker.image = [UIImage imageNamed:@"P03.png"];
            
			pg03 = [page03 alloc];
			[self pageOpenView:pg03 direction:curlup];	
			//[pg03 release];
            
			break;		
					
		case 3:
			masker.image = [UIImage imageNamed:@"P04.png"];
            
			pg04 = [page04 alloc];
			[self pageOpenView:pg04 direction:curlup];
			//[pg04 release];
			break;	
	
		case 4:
			
			masker.image = [UIImage imageNamed:@"P05.png"];
            
			//if (pg02 == nil) {
			
			pg05 = [page05 alloc];
			[self pageOpenView:pg05 direction:curlup];	
			//[pg05a release];
			break;		
			

		case 5:
			masker.image = [UIImage imageNamed:@"P06.png"];
            
			pg06 = [page06 alloc];
			
			[self pageOpenView:pg06 direction:curlup];	
			//[pg06 release];
			break;	
			
		case 6:
			masker.image = [UIImage imageNamed:@"P07.png"];
            
			pg07 = [page07 alloc];
			
			[self pageOpenView:pg07 direction:curlup];	
			
			//[pg07 release];
			break;	
            
		case 7:
			masker.image = [UIImage imageNamed:@"P08.png"];
            
			pg08 = [page08 alloc];
			[self pageOpenView:pg08 direction:curlup];	
			//[pg08 release];
			
			break;	
			
		case 8:
			masker.image = [UIImage imageNamed:@"P09.png"];
            
			pg09 = [page09 alloc];
			[self pageOpenView:pg09 direction:curlup];	
			//[pg09 release];
			break;	
			
		case 9:
			masker.image = [UIImage imageNamed:@"P10.png"];
            
			pg10 = [page10 alloc];
			[self pageOpenView:pg10 direction:curlup];	
			//[pg10 release];
			break;	
            
		case 10:
			masker.image = [UIImage imageNamed:@"P11.png"];
            
			pg11 = [page11 alloc];
			[self pageOpenView:pg11 direction:curlup];	
			//[pg11 release];
			break;	
			
		case 11:
			masker.image = [UIImage imageNamed:@"P12.png"];
            
			pg12 = [page12 alloc];
			[self pageOpenView:pg12 direction:curlup];	
			//[pg12 release];
			break;	
			
		case 12:
			masker.image = [UIImage imageNamed:@"P13.png"];
            
			pg13 = [page13 alloc];
			[self pageOpenView:pg13 direction:curlup];	
			//[pg13a release];
			break;		
			
		case 13:
			masker.image = [UIImage imageNamed:@"P14.png"];
            
			pg14 = [page14 alloc];
			[self pageOpenView:pg14 direction:curlup];	
			//[pg14 release];
			break;	
            
		case 14:
			masker.image = [UIImage imageNamed:@"P15.png"];
			pg15 = [page15 alloc];
			[self pageOpenView:pg15 direction:curlup];			
			break;	
			
		case 15:
			masker.image = [UIImage imageNamed:@"P16.png"];
			pg16 = [page16 alloc];
			[self pageOpenView:pg16 direction:curlup];	
			//[pg16 release];
			break;	
			
		case 16:
			masker.image = [UIImage imageNamed:@"P17.png"];
            
			pg17 = [page17 alloc];
			[self pageOpenView:pg17 direction:curlup];
			//[pg17 release];
			break;		
			
		case 17:
			masker.image = [UIImage imageNamed:@"P18.png"];
            
			pg18 = [page18 alloc];
			[self pageOpenView:pg18 direction:curlup];		
			//[pg18 release];
			break;		
			
		case 18:
			masker.image = [UIImage imageNamed:@"P19.png"];
            
			pg19 = [page19 alloc];
			[self pageOpenView:pg19 direction:curlup];	
			//[pg19 release];
			break;	
	/*		
		case 20:
			masker.image = [UIImage imageNamed:@"P20.png"];
			
			credits_pg = [credits_page alloc];
			[self pageOpenView:credits_pg direction:curlup];	
			//[credits_pg release];
			break;	
     
     */
	}
	
    
    
    
	masker.hidden = NO;
	refreshable = NO;
	refresh.hidden = YES;
    
	
}

- (void) pageOpenView:(house_page *)viewControllerToOpen direction:(BOOL)curl {
    
    
	
    [currentViewController stopAudio];
    
	transitioning = YES;
	
	//}
	
	
	
	
	//UIView * view1 = currentViewController.view;
	UIView * view2 = masker;
	
	view2.hidden = YES;
	//[holder addSubview:view2];
	//[holder insertSubview:view2 belowSubview:[holder viewWithTag:555]];
	
    // First create a CATransition object to describe the transition
	
    CATransition *transition = [CATransition animation];
	
    // Animate over 3/4 of a second
	
    transition.duration = 0.2;
	
    // using the ease in/out timing function
	
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
    
	
    // Now to set the type of transition. Since we need to choose at random, we'll setup a couple of arrays to help us.
	
    NSString *types[4] = {kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal, kCATransitionFade};
	
    NSString *subtypes[4] = {kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom};
	
    //int rnd = random() % 4;
	
    transition.type = types[2];
	
	if(curl){
		transition.subtype = subtypes[1];
	}
	else {
		transition.subtype = subtypes[0];
	}
	
	if (refreshable){
		refreshable = NO;
		transition.type = types[3];
		
	}
	
	
    // Finally, to avoid overlapping transitions we assign ourselves as the delegate for the animation and wait for the
	
    // -animationDidStop:finished: message. When it comes in, we will flag that we are no longer transitioning.
	
    //transitioning = YES;
	
    transition.delegate = self;
	
    
	
    // Next add it to the containerView's layer. This will perform the transition based on how we change its contents.
	
    [holder.layer addAnimation:transition forKey:nil];
	
    
	
    // Here we hide view1, and show view2, which will cause Core Animation to animate view1 away and view2 in.
	
	// view1.hidden = YES;
	
    view2.hidden = NO;
    
	//vcToOpen = 
    
	
	if (currentViewController != nil){
		
        
		[currentViewController.view removeFromSuperview];
		[currentViewController dealloc];
        NSLog(@"primary view controller done deallocating previous page");
	}
    
    NSLog(@"primary view controller about to allocate current view Controller");
    
    
	currentViewController = viewControllerToOpen; 
    
    
    NSLog(@"primary view just switched pointer for currentViewController");
    
    
    
//	[currentViewController init_dgpage];
    
	[holder insertSubview:currentViewController.view belowSubview:[holder viewWithTag:555]];
    [currentViewController presetLanguage:language_suffix];
    
	[currentViewController setVolume:narrationVolume];
	[currentViewController setSoundtrackVolume:soundtrackVolume];
	[currentViewController setHints:hints_on];
    
    
	
	NSLog(@"animation done");
	
    
}


-(void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag

{
	
	
	/*
	 
	 Initializing pages by sending variables from this class into the currentViewController
	 
	 */
	
	
	/*
	 Here we refresh the volumes of each component on each page. 
	 Each house_page contains its own players that need to be reminded of the global settings for volume.
	 */
	
	[holder viewWithTag:555].hidden = YES;
    
	transitioning = NO;
}




/*
 // The designated initializer. Override to perform setup that is required before the view is loaded.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */




- (void)oneFingerSwipeLeft:(UISwipeGestureRecognizer *)recognizer 
{ 
	CGPoint point = [recognizer locationInView:[self view]];
	NSLog(@"Swipe left - start location: %f,%f", point.x, point.y);
	//current_page++;
	if (current_page > 3) {
		//here is the end of the book.
		//current_page = 3;
	}
	
    
}

- (void)oneFingerSwipeRight:(UISwipeGestureRecognizer *)recognizer 
{ 
	CGPoint point = [recognizer locationInView:[self view]];
	NSLog(@"Swipe right - start location: %f,%f", point.x, point.y);
	
	//current_page--;
	if (current_page < -1) {
		//here is the end of the book.
		//current_page = -1;
	}
	
}

- (void) update:(CADisplayLink*)displayLink {
    
    
	
	if([currentViewController refreshable] && !refreshable){
		
		if(current_page != 0){
			refreshable = YES;
			refresh.hidden = NO;
		}
		
	}
    
	if(![currentViewController refreshable] && refreshable){
        
        refreshable = NO;
        refresh.hidden = YES;
        
	}
	
	main_counter++;
	
	if(main_counter == 2){
        
		AudioServicesPlaySystemSound(preload_sound);
		
	}
	
    if(main_counter > (120 + 50) && main_counter < (135 + 50)){
        
        preloader.alpha = (float)((135 + 50) - main_counter)/15.0;
        
    }
    if(main_counter > (135 + 50) && main_counter < (140 + 50)){
        
        preloader.alpha = 0;
        
    }
	
	if(main_counter == (140 + 50)){
        
        NSLog(@"Removing preloader");

		[preloader removeFromSuperview];
		
	}
	if(main_counter == 100){
        NSLog(@"Link about to setup book");

        
		[self setupBook];
		
	}
	if(requesting && ((main_counter - main_counter_last_request) > 1) && !transitioning){	
		/*
		 This is a hack that allows 10 frames to pass before sending the trigger message to go to the next page.
		 This gives the page time to take a screen grab of what is currently happening and print it to the screen before getting rid of 
		 its contents.
		 */
		[self gotoPage:main_tag];
		requesting = NO;
	}
	/*
	 
	 Every page (stored as currentViewController) will respond to tick. 
	 We can use this to track counters / run custom animation and make decisions over time.
	 
	 */
	//NSLog(@"Mother Tick");
	
	if (currentViewController != nil){
		//NSLog(@"Current View Controller is not nil");
		[currentViewController tick];
	}
	
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	
	//Lock orientation in landscape
	if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) { return YES; } return NO; 
}

- (void)didReceiveMemoryWarning {
	
	NSLog(@"Memory warning! in tabcustomVie");
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	
	AudioServicesDisposeSystemSoundID (page_turn_sound);
	AudioServicesDisposeSystemSoundID (preload_sound);
    
	//[narrationSlider release];  
    [super dealloc];
}

@end
