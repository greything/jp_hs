//
//  house_page.h
//  TheHouseThatWentOnStrike
//
//  Created by Marilys Ernst on 10/5/11.
//  Copyright 2011 MI Artbox, Incorporated. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#include <AudioToolbox/AudioToolbox.h>
#import <MediaPlayer/MediaPlayer.h>
@interface house_page : UIViewController <UIAccelerometerDelegate>{
	
	//Text Element. Hopefully this will be able to be copied easily
	AVAudioPlayer *narrationPlayer;
	AVAudioPlayer *soundtrackPlayer;
	AVAudioPlayer *sfxPlayer;
    
	CFURLRef soundFileURLRef;
    
	int page_counter;
	
	IBOutlet UIWebView *webView;
	NSString *html_name;
	NSString* narration_name;
	NSString *language;
    
	NSString *soundtrack_name;
	
	NSString *sfx_name;
	
	NSString *video_name;
	
	NSString *mask_name;
	
	BOOL manual_web;
	BOOL manual_hints;
    
	BOOL one_shot_soundtrack;
	BOOL one_shot_sfx;
	
	CGRect webRect;
	
	float f_time;
	int word_count;
	int last_word_count;
    
    bool DE_edition;
    
	
	MPMoviePlayerController *videoPlayer;
	NSURL *videoURL;
	
	UIImageView* masky;
	
	
	UIImageView* hint;
    
	
	NSString *hint_name;
	NSString *subhint_name;
    
	BOOL mask_off;
	
	BOOL waiting_for_web;
	
	BOOL show_hints;
    
	BOOL refreshable;
	
	BOOL soundsOn;
    
    BOOL manual_sound;
    BOOL manual_narration;
    
	//End of Text Stuff
	
}
-(void)upMask;
-(void)showWebview;
-(void)dropMask;
-(void)tick;
-(void)setVolume:(float)vol;
-(void)setSoundtrackVolume:(float)vol;
-(void)setHints:(BOOL)hinting;
-(void)stopAudio;
-(void)playMovie;
-(void)prepOneShotMovie;
-(void)init_dgpage;
-(void)presetLanguage:(NSString *)lang;

-(void)setLanguage;

-(void)setUpSound;

-(void)startAccelerometer;
-(void)stopAccelerometer;

-(void)triggerOneShotMovie;

@property (readwrite)   CFURLRef        soundFileURLRef;
@property (nonatomic, retain) MPMoviePlayerController *videoPlayer;


//Text element.
@property (readwrite)   BOOL        refreshable;
@property (readwrite)   BOOL        soundsOn;

@property (nonatomic, retain) NSString *html_name;
@property (nonatomic, retain) NSString *narration_name;
@property (nonatomic, retain) NSString *soundtrack_name;
@property (nonatomic, retain) NSString *video_name;

@property (nonatomic, retain) AVAudioPlayer *narrationPlayer;
@property (nonatomic, retain) AVAudioPlayer *soundtrackPlayer;
@property (nonatomic, retain) AVAudioPlayer *sfxPlayer;

@property (nonatomic) CGRect webRect;

@property (nonatomic, retain) UIWebView *webView;
//End of text stuff

@end

