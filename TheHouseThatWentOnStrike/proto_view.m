//
//  proto_view.m
//  TheHouseThatWentOnStrike
//
//  Created by Marilys Ernst on 10/5/11.
//  Copyright 2011 MI Artbox, Incorporated. All rights reserved.
//

#import "proto_view.h"


@implementation proto_view

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void) setImageTo:(NSString*)str{
    
    main_image = [[UIImageView alloc] initWithImage: [UIImage imageNamed:str]];
    self.frame = main_image.frame;
    [self addSubview:main_image];
        
}

- (void)dealloc
{
    [super dealloc];
}

@end
