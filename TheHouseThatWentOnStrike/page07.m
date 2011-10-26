//
//  page07.m
//  TheHouseThatWentOnStrike
//
//  Created by Marilys Ernst on 10/5/11.
//  Copyright 2011 MI Artbox, Incorporated. All rights reserved.
//

#import "page07.h"

#import "proto_view.h"

@implementation page07

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    mask_name = @"panel07b.jpg";
    
    bg = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,1024,768)];
    bg.image = [UIImage imageNamed:@"P07_Background_FPO.jpg"];
    [self.view addSubview:bg];
    
    //Revisit Text
    text = [[UIImageView alloc] initWithFrame:CGRectMake(10,10,330,1210)];
    text.image = [UIImage imageNamed:@"P07_Text_FPO.jpg"];
    [self.view addSubview:text];
    
    //Revisit Text
    text_matte = [[UIImageView alloc] initWithFrame:CGRectMake(0,85,377,683)];
    text_matte.image = [UIImage imageNamed:@"P07_TextMatte_FPO.png"];
    [self.view addSubview:text_matte];
    
    proto = [[proto_view alloc] initWithFrame:CGRectMake(0,0,20,20)];
    [proto setImageTo:@"C_Fridge_S1_FPO"];
    proto.userInteractionEnabled = YES;
    [self.view addSubview:proto];
    
    proto2 = [[proto_view alloc] initWithFrame:CGRectMake(700,0,20,20)];
    [proto2 setImageTo:@"C_Stove_S1_FPO"];
    proto2.userInteractionEnabled = YES;
    [self.view addSubview:proto2];
    
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	for (UITouch *touch in touches) {
        NSArray *array = touch.gestureRecognizers;
        for (UIGestureRecognizer *gesture in array) {
            if (gesture.enabled && [gesture isMemberOfClass:[UIPinchGestureRecognizer class]]) {
                gesture.enabled = NO;
            }
        }
    }
    
    //grab a touch
    UITouch *touch = [[event allTouches] anyObject];
	
	// get the touch location
	CGPoint touchLocation = [touch locationInView:self.view];
    
    
    if([touch view] == proto){
        proto.center = touchLocation;
    }
    if([touch view] == proto2){
        proto2.center = touchLocation;
    }
    
    if(!text_scroll_locked){
        text_y_when_locked = text.center.y;
        finger_y_when_locked = touchLocation.y;
        text_scroll_locked = YES;
    }
    else{
        text.center = CGPointMake(text.center.x, text_y_when_locked + (touchLocation.y - finger_y_when_locked));
    }
    
    NSLog(@"%f", text.center.y);
    
    if(text.center.y < -400){
        
        text.center = CGPointMake(text.center.x, -400);
        
    }
    if(text.center.y > 642){
        
        text.center = CGPointMake(text.center.x, 642);
        
    }
 
    
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
	[self touchesBegan:touches withEvent:event];
	
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	
    text_scroll_locked = NO;
	
}


@end
