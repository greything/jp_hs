//
//  page07.h
//  TheHouseThatWentOnStrike
//
//  Created by Marilys Ernst on 10/5/11.
//  Copyright 2011 MI Artbox, Incorporated. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "house_page.h"
#import "proto_view.h"


@interface page07 : house_page {
    
    UIImageView * bg;
    UIImageView * text;
    UIImageView * text_matte;
    
    proto_view* proto;
    proto_view* proto2;
    
    bool text_scroll_locked;
    float text_y_when_locked;
    float finger_y_when_locked;
}

@end
