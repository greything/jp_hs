//
//  house_page.m
//  TheHouseThatWentOnStrike
//
//  Created by Marilys Ernst on 10/5/11.
//  Copyright 2011 MI Artbox, Incorporated. All rights reserved.
//

#import "house_page.h"


@implementation house_page
@synthesize soundFileURLRef;
@synthesize videoPlayer;
@synthesize refreshable;
@synthesize soundsOn;

@synthesize sfxPlayer;
@synthesize soundtrackPlayer;
@synthesize narrationPlayer;

@synthesize html_name;
@synthesize narration_name;
@synthesize soundtrack_name;
@synthesize video_name;
@synthesize webView;

@synthesize webRect;


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization.
 }
 return self;
 }
 */

//-(void)init{

//    NSLog(@"DGPage Init");

//}

- (void)accelerometer:(UIAccelerometer *)accelerometer
        didAccelerate:(UIAcceleration *)acceleration
{
    
	
}

-(void)presetLanguage:(NSString *)lang{
    
    language = lang;
    
    if(!manual_narration){
        [self setLanguage];
    }
    
}

-(void)setLanguage{
    
    
    NSLog(@"xxxxxxxxxx Setting language to %@", language);
    if(narration_name){
        
        
        NSRange match;
        
        match = [narration_name rangeOfString: @"_"];
        
        NSLog (@"match found at index %i", match.location);
        
        NSLog (@"match length = %i", match.length);
        
        // [narration_name appendString: @" over the lazy dog"];
        
        NSLog(@"and the language is going to be %@", language);
        
        NSMutableString * nar_string;
        
        nar_string = [NSMutableString stringWithString:[[NSMutableString stringWithString: narration_name] substringWithRange: NSMakeRange (0, match.location)]];
        
        [nar_string appendString: @"_"];
        [nar_string appendString: language];
        [nar_string appendString: @".mp3"];
        
        NSLog (@"nar_string = %@", nar_string);  
        
        
        NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], nar_string ]];
        
        narrationPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        narrationPlayer.numberOfLoops = 0;
        
        //    [narrationPlayer setDelegate:self];
        
        
        
        //Dialog Audio is started here. This should be bundled into its own methods.
        
        if (narrationPlayer == nil){
            NSLog(@"narration player is not gonna play");
            [narrationPlayer release];
            narrationPlayer = nil;
            
        }
        else{
            NSLog(@"narration player is gonna play");
            [narrationPlayer play];
        }
	}
    
    
    
    
}

- (void)startAccelerometer {
	
	UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
	accelerometer.delegate = self;
	accelerometer.updateInterval = 0.05;
    
}

- (void)stopAccelerometer {
	
	UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
	accelerometer.delegate = nil;
	
}
-(void)viewWillAppear:(BOOL)animated{
	
    
	NSLog(@"view will appear");
	
}

- (void)loadView{
	
	NSLog(@"dg_page loadView");
	
	
	[super loadView];
	
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
	NSLog(@"dgPage view did load");
	
	language = @"";
	
	refreshable = NO;
    
	page_counter = 0;
	
	waiting_for_web = YES;
    
	
	hint = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,1024,768)];
    hint.image = [UIImage imageNamed:hint_name];
	hint.userInteractionEnabled = NO;
	hint.alpha = 0;
    [self.view addSubview:hint];
	[hint release];
	
	
	UIImageView* sub_hint = [[UIImageView alloc] initWithFrame:CGRectMake(600,690,286,68)];
    sub_hint.image = [UIImage imageNamed:subhint_name];
	sub_hint.userInteractionEnabled = NO;
	sub_hint.alpha = .3;
    [hint addSubview:sub_hint];
	[sub_hint release];
    
    
	
	/****************************************************************************************/
	//Set up area for text
    //Initialize webview
	webView = [[UIWebView alloc] initWithFrame:webRect];
	webView.tag = 404;
	//Clear Background
	
	webView.backgroundColor = [UIColor clearColor];  
	[webView setOpaque:NO];
	
	//Get path to file so we can reference jquery
	NSString *path = [[NSBundle mainBundle] bundlePath];
	NSURL *baseURL = [NSURL fileURLWithPath:path];
	
	//Specify name of html file. This should be different for each page
	NSString *filePath = [[NSBundle mainBundle] pathForResource:html_name ofType:@"html"];  
	NSData *htmlData = [NSData dataWithContentsOfFile:filePath];
	
	if (htmlData) {  
		[webView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:baseURL];  
	}
	
	//locks uiwebview from scrubbing
	UIScrollView* sv = nil;
	for(UIView* v in webView.subviews){
		if([v isKindOfClass:[UIScrollView class] ]){
			sv = (UIScrollView*) v;
			sv.scrollEnabled = NO;
			sv.bounces = NO;
		}
	}
	webView.userInteractionEnabled = NO;
	webView.alpha = 0;
	[self.view addSubview:webView]; 
	[webView release];
	
	mask_off = NO;
	masky = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,1024,768)];
    masky.image = [UIImage imageNamed:mask_name];
    [self.view addSubview:masky];
	[masky release];
	
	word_count = 0;
	last_word_count = -1;
    
    if(!manual_sound){
        [self setUpSound];
    }
	
	self.view.frame = CGRectMake(0, 0, 1024, 768);
	
    [super viewDidLoad];
}//end of viewdidload

-(void)setUpSound{
    
    /****************************************************************************************/
    if(soundtrack_name){	
        NSURL *url_st = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], soundtrack_name ]];
        soundtrackPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url_st error:nil];
        //  [soundtrackPlayer setDelegate:self];
        
        
        //  soundtrackPlayer = [self audioPlayerWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], soundtrack_name ]];
        
        
        if(!one_shot_soundtrack){
            
            soundtrackPlayer.numberOfLoops = -1;
            
        }
        else{
            
            soundtrackPlayer.numberOfLoops = 0;
            
        }
        
        
        //Soundtrack Audio is started here. This should be bundled into its own methods.
        
        if (soundtrackPlayer == nil){
            NSLog(@"soundtrack player is not gonna play");
            [soundtrackPlayer release];
            soundtrackPlayer = nil;
            
        }
        else{
            NSLog(@"soundtrack player is gonna play");
            [soundtrackPlayer play];
            //[soundtrackPlayer autorelease];
        }
    }
    
    if(sfx_name){
        
        
        NSURL *url_sfx = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], sfx_name ]];
        sfxPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url_sfx error:nil];
        // [sfxPlayer setDelegate:self];
        
        //sfxPlayer = [self audioPlayerWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], sfx_name ]];
        
        if(!one_shot_sfx){
            
            sfxPlayer.numberOfLoops = -1;
            
        }
        else{
            
            sfxPlayer.numberOfLoops = 0;
            
        }	
        //Soundtrack Audio is started here. This should be bundled into its own methods.
        
        
        if (sfxPlayer == nil){
            NSLog(@"SFX player is not gonna play");
            [sfxPlayer release];
            sfxPlayer = nil;
            
        }
        else{
            NSLog(@"SFX player is gonna play");
            [sfxPlayer play];
            // [sfxPlayer autorelease];
        }
        
    }
    
    
    
}

- (AVAudioPlayer *)audioPlayerWithContentsOfFile:(NSString *)path {
    NSData *audioData = [NSData dataWithContentsOfFile:path];
    AVAudioPlayer *player = [AVAudioPlayer alloc];
    if([player initWithData:audioData error:NULL]) {
        NSLog(@"Player with data");
        [player autorelease];
    } else {
        NSLog(@"Player is nil");
        [player release];
        player = nil;
    }
    return player;
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
	if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) { return YES; } return NO; 
}

- (void)setVolume:(float)vol{
	
	narrationPlayer.volume = vol;
	
}

- (void)stopAudio{
	
    if(narrationPlayer){
        
        [narrationPlayer stop];
        
    }
    if(soundtrackPlayer){
        
        [soundtrackPlayer stop];
        
    }
    if(sfxPlayer){
        
        [sfxPlayer stop];
        
    }
}

- (void)setSoundtrackVolume:(float)vol{
	
	if(vol == 0){
        
		soundsOn = NO;
		
	}
	else {
		soundsOn = YES;
	}
    
	
	
	soundtrackPlayer.volume = vol;
	sfxPlayer.volume = vol;
}

-(void)setHints:(BOOL)hinting{
    
	show_hints = hinting;
	if(!show_hints){
        
		refreshable = YES;
		
	}
	else{
		
		refreshable = NO;
		
	}
	
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
	refreshable = YES;
}


- (void)didReceiveMemoryWarning {
    
    NSLog(@"DGPage Memory Warning");
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
	NSLog(@"dg_page did unload");
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)die {
	
	//THis section needs to be fleshed out to include
	
	NSLog(@"die dg_page");
	
	if(self.videoPlayer){
		
		NSLog(@"video player during die");
		//[self.videoPlayer pause];
        //[self.videoPlayer release];
	}
    
	[narrationPlayer stop];
	[soundtrackPlayer stop];
	[sfxPlayer stop];
	
    
	
	
	/*
     if(soundFileURLRef){
     CFRelease (soundFileURLRef);
     }
	 */
	
	[super dealloc];
}


- (void)dealloc {
	
	UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
	accelerometer.delegate = nil;
	
	//THis section needs to be fleshed out to include
	
    if(narration_name){
        
        [narrationPlayer autorelease];
        
    }
    if(soundtrack_name){
        
        [soundtrackPlayer autorelease];
        
        
    }
    
    if(sfx_name){
        
        [sfxPlayer autorelease];
        
        
    }
	
	//[videoPlayer pause];
	//[narrationPlayer stop];
	//[narrationPlayer release];
	//[soundtrackPlayer stop];
	//[soundtrackPlayer release];
	
    //[sfxPlayer stop];
	//[sfxPlayer release];
    
	
	if(soundFileURLRef){
        CFRelease (soundFileURLRef);
	}
    
    if(videoPlayer){
        //  [videoPlayer pause];
        [videoPlayer stop];
        [videoPlayer release];
        NSLog(@"autoreleased dgpage");
    }
    else{
        
        NSLog(@"Dgpage - no videoPlayer to kill");
        
    }
    [super dealloc];
	NSLog(@"dealloc dg_page");
    
}

-(void)loadMovie {
	
	NSLog(@"vid play %@", video_name);
	
	NSString *urlStr = [[NSBundle mainBundle] pathForResource:video_name ofType:nil];
	
	NSURL *url = [NSURL fileURLWithPath:urlStr];
	
	//NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], video_name ]];
	
	if(videoPlayer){
		
		NSLog(@"video player exists");
        //[videoPlayer release];
        [videoPlayer stop];
        [videoPlayer.view removeFromSuperview];
        [videoPlayer release];
	}
	else {
		NSLog(@"video player does not exist");
	}
	
	
	videoPlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
	videoPlayer.controlStyle = MPMovieControlStyleNone;
	videoPlayer.view.tag = 555666;
	videoPlayer.view.alpha = 1;
	videoPlayer.view.frame = CGRectMake(0, 0,1024,768);
    
	[self.view insertSubview:videoPlayer.view belowSubview:[self.view viewWithTag:404]];
	[self.view sendSubviewToBack:videoPlayer.view];
    
    //[videoPlayer autorelease];
    
}



-(void)playMovie {
    NSLog(@"DGPage Play Movie");
    
	[self loadMovie];
	
	
	/*
	 [[NSNotificationCenter defaultCenter] addObserver:self 
	 selector:@selector(myMovieFinishedCallback:) 
	 name:MPMoviePlayerPlaybackDidFinishNotification 
	 object:videoPlayer]; 
	 */
	
	//[self.view addSubview:videoPlayer.view];
	
	
	videoPlayer.repeatMode = MPMovieRepeatModeOne;
	[videoPlayer play];
	//videoPlayer.view.alpha = 1;
	
}

-(void)prepOneShotMovie {
	
	NSLog(@"vid play %@", video_name);
	
	
	NSString *urlStr = [[NSBundle mainBundle] pathForResource:video_name ofType:nil];
	
	NSURL *url = [NSURL fileURLWithPath:urlStr];
	
	//NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], video_name ]];
	
	if(videoPlayer){
		
		NSLog(@"video player exists");
        NSLog(@"video player exists");
        //[videoPlayer release];
        [videoPlayer stop];
        [videoPlayer.view removeFromSuperview];
        [videoPlayer release];
	}
	else {
		NSLog(@"video player does not exist");
	}
	
	
	videoPlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
	
	videoPlayer.controlStyle = MPMovieControlStyleNone;
	
	videoPlayer.view.tag = 555666;
	
	
	/*
	 [[NSNotificationCenter defaultCenter] addObserver:self 
	 selector:@selector(myMovieFinishedCallback:) 
	 name:MPMoviePlayerPlaybackDidFinishNotification 
	 object:videoPlayer]; 
	 */
	
	//[self.view addSubview:videoPlayer.view];
	[self.view insertSubview:videoPlayer.view belowSubview:[self.view viewWithTag:404]];
	videoPlayer.view.frame = CGRectMake(0, 0,1024,768);  
	
	[self.view sendSubviewToBack:videoPlayer.view];
	videoPlayer.repeatMode = MPMovieRepeatModeNone;	
	videoPlayer.shouldAutoplay = NO;
    
    
}

-(void)dropMask{
    NSLog(@"DGPage Drop Mask disabled un comment block when ready to build pages");

	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:.1];
	[UIView setAnimationDelay:0];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	
	masky.alpha = 0;
	[UIView commitAnimations];
    
}

-(void)showWebview{
    NSLog(@"DG Page Show Webview");
    
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:2];
	[UIView setAnimationDelay:0];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	
	webView.alpha = 1;
	[UIView commitAnimations];
	
}

-(void)upMask{
    NSLog(@"DGPage Upmask");
    
	self.view.frame = CGRectMake(0,0,1024,768);
	
	UIImageView* tempy = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,1024,768)];
    tempy.image = [videoPlayer thumbnailImageAtTime:[videoPlayer currentPlaybackTime] timeOption:MPMovieTimeOptionExact];
    [self.view insertSubview:tempy aboveSubview:videoPlayer.view];
	[tempy release];
	
	
	UIGraphicsBeginImageContext(self.view.frame.size);  
    [[self.view layer] renderInContext:UIGraphicsGetCurrentContext()];   
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();   
	
	masky.image = screenshot;
	
    UIGraphicsEndImageContext();              
    
	masky.alpha = 1;
    
}

-(void)triggerOneShotMovie {
    NSLog(@"DGPage Trigger Oneshot");
    
	if(videoPlayer){
		
		videoPlayer.repeatMode = MPMovieRepeatModeNone;
		videoPlayer.currentPlaybackTime = 0;
		[videoPlayer play];
        
	}
    
}



// When the movie is done,release the controller. 
-(void)myMovieFinishedCallback:(NSNotification*)aNotification 
{
	NSLog(@"moviecallback!");	
    MPMoviePlayerController* theMovie=[aNotification object]; 
    [[NSNotificationCenter defaultCenter] removeObserver:self 
                                                    name:MPMoviePlayerPlaybackDidFinishNotification 
                                                  object:theMovie]; 
	
    // Release the movie instance created in playMovieAtURL
    [theMovie release];
	
}


- (void) tick {
    
	int temp_page_counter = page_counter - 200;
	
	if(show_hints && !manual_hints){
		if(temp_page_counter < 200){
			
			hint.alpha = (float)temp_page_counter/(float)200;	
			
		}
        
		else if(temp_page_counter < 800){
			
			hint.alpha = (float)(100 - (temp_page_counter - 600))/(float)100;
			
		}
		else if(temp_page_counter > 800){
			
			hint.alpha = 0;
			refreshable = YES;
		}
		else {
			hint.alpha = 0;
		}
        
        
	}
	
	if(refreshable){
        
		hint.alpha = 0;
		
	}
	
	
	if(waiting_for_web && page_counter > 50 && !manual_web){
        
		[self showWebview];
		waiting_for_web = NO;
		
	}
	
	BOOL ready_for_page = !mask_off && (([videoPlayer currentPlaybackTime] > 0) || (page_counter > 20)); 
	
	/*************************************************************************************************************/
	if(ready_for_page && !(mask_name == @"P01.png")){
		
		
		NSLog(@"trying to drop");
		[self dropMask];
		mask_off = YES;
		
		
	}
	else if(ready_for_page && (mask_name == @"P01.png") && ([videoPlayer currentPlaybackTime] > 1)){
        
		NSLog(@"trying to drop");
		
		[self dropMask];
        
		mask_off = YES;
	}
    
	/*
     
     //Grab the current time code
     if([narrationPlayer isPlaying]){
     f_time = [narrationPlayer currentTime];
     //Consult array for beginning time of word and time of the following word
     
     float d_time = [[word_array objectAtIndex:word_count] floatValue];
     float d_time_e = [[word_array objectAtIndex:word_count + 1] floatValue];
     
     //If the player is currently between the two times (on the word)
     if((f_time >= d_time && f_time < d_time_e)){
     
     //Check if the word has been used
     if(word_count != last_word_count){
     
     //Call the javascript to light up the word
     [webView stringByEvaluatingJavaScriptFromString:[NSMutableString stringWithFormat:@"hlt(%d)", word_count]];
     last_word_count = word_count;
     }
     }
     //If you are not between the times, try incrementing the word iterator
     else if(f_time >= d_time){
     word_count = word_count+1;
     }
     
     //This one doesnt work yet, resetting to 0
     if (word_count >= [word_array count]){
     word_count = 0;
     }
     }//end of if isPlaying
     
     NSString *return_from_js = [webView stringByEvaluatingJavaScriptFromString:[NSMutableString stringWithFormat:@"get_most_recent()"]];
     //NSLog(@"%@", return_from_js);
     
     if(![return_from_js isEqualToString:@"-1"]){
     //[narrationPlayer stop];
     if(word_count != 0){
     [narrationPlayer stop];
     [narrationPlayer setCurrentTime:0.0];
     [narrationPlayer play];
     word_count = 0;
     }
     }
     */
	/*************************************************************************************************************/
	
	page_counter++;
}


@end

