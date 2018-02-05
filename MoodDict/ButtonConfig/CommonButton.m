//
//  CommonButton.m
//  MoodDict
//
//  Created by Shawn on 2018/2/5.
//  Copyright © 2018年 李嘉银. All rights reserved.
//

#import "CommonButton.h"
#import <Masonry.h>

@implementation CommonButton

-(instancetype)init{
    self = [super init];
    if (self) {
        [self setUpButton];
    }
    return self;
    
}

-(void)setUpButton{
    UIColor * btnColor = [UIColor colorWithRed:216.0/255.0 green:216.0/255.0 blue:216.0/255.0 alpha:1.0];
    self.backgroundColor = btnColor;
    self.layer.cornerRadius = 5.0;
    [self setTitleColor:[UIColor colorWithRed:48.0/255 green:99.0/255 blue:269.0/255 alpha:1.0] forState:UIControlStateNormal];
}

    

/*
 
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
