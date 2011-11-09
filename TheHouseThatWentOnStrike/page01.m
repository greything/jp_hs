//
//  page01.m
//  TheHouseThatWentOnStrike
//
//  Created by Marilys Ernst on 10/5/11.
//  Copyright 2011 MI Artbox, Incorporated. All rights reserved.
//

#import "page01.h"


@implementation page01

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
    
    slider_x = 0;
    slider_y = 0;
    [super viewDidLoad];
    
    UIImageView * bg_a = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,1024,768)];
    bg_a.image = [UIImage imageNamed:@"panel02.jpg"];
    
    [self.view addSubview:bg_a];
    
    
    selectedImage = [UIImage imageNamed:@"P07_Background_FPO.jpg"];

    mask = [UIImage imageNamed:@"circle_grey.png"];
    
    magni = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,512,512)];
    magni.image = [self maskImage:selectedImage usingRect:CGRectMake(10,10,500,500) withMask:mask];
    magni.opaque = NO;
    magni.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:magni];
    
    
    
    
}

- (UIImage*) maskImage:(UIImage *)image usingRect:(CGRect)cropRect withMask:(UIImage *)maskImage {
    
    
    CGImageRef imageNoAlpha = CGImageCreateWithImageInRect([image CGImage], cropRect);
    
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceRGB();
    CGFloat width = CGImageGetWidth(imageNoAlpha);
    CGFloat height = CGImageGetWidth(imageNoAlpha);
    CGContextRef ctxWithAlpha = CGBitmapContextCreate(nil, width, height, 8, 4*width, cs, kCGImageAlphaPremultipliedFirst);
    
    CGContextDrawImage(ctxWithAlpha, CGRectMake(0, 0, width, height), imageNoAlpha);
    CGImageRef imageWithAlpha = CGBitmapContextCreateImage(ctxWithAlpha);
    
    //from before:
    
	CGImageRef maskRef = maskImage.CGImage;
	CGImageRef masker = CGImageMaskCreate(CGImageGetWidth(maskRef),
										CGImageGetHeight(maskRef),
										CGImageGetBitsPerComponent(maskRef),
										CGImageGetBitsPerPixel(maskRef),
										CGImageGetBytesPerRow(maskRef),
										CGImageGetDataProvider(maskRef), NULL, false);
	CGImageRef masked = CGImageCreateWithMask(imageWithAlpha, masker);
	CGImageRelease(masker);
    
    //Testing image releasing
    CGImageRelease(imageNoAlpha);
    CGImageRelease(imageWithAlpha);
    
    CGContextRelease(ctxWithAlpha);
    //CGImageRelease(maskRef);

	UIImage* retImage= [UIImage imageWithCGImage:masked];
	CGImageRelease(masked);
	return retImage;
	
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
    
    slider_x = (touchLocation.x / 1024.0) * 724.0;
    slider_y = (touchLocation.y / 768.0) * 468.0;

    magni.center = touchLocation;
    /*
    if([touch view] == proto){
        proto.center = touchLocation;
    }
    */

    
    
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
	[self touchesBegan:touches withEvent:event];
	
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	
	
}


-(void)tick{
    

    magni.image = magni.image = [self maskImage:selectedImage usingRect:CGRectMake(slider_x,slider_y,300,300) withMask:mask];

    
}

@end
