//
//  page01.h
//  TheHouseThatWentOnStrike
//
//  Created by Marilys Ernst on 10/5/11.
//  Copyright 2011 MI Artbox, Incorporated. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "house_page.h"

#import <QuartzCore/QuartzCore.h>

@interface page01 : house_page {
    UIImage *selectedImage;
    UIImage *mask;
    
    UIImageView * magni;
    int slider_x;
    int slider_y;
}

@end
