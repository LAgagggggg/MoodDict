//
//  KeyWordButton.m
//  MoodDict
//
//  Created by Shawn on 2018/2/6.
//  Copyright © 2018年 李嘉银. All rights reserved.
//

#import "KeyWordButton.h"
#import <math.h>
@interface KeyWordButton()<CAAnimationDelegate> // 二级关键词

@property(nonatomic, strong) NSString * name;

@end


@implementation KeyWordButton

-(instancetype)init{
    self = [super init];
    if (self) {
        [self autoLocated];
        [self autoColored];
//        [self addTarget:self action:@selector(animated) forControlEvents:UIControlEventAllTouchEvents];
    }
    
    return self;
}

-(void)autoLocated{
    float x, y, r;
    x = arc4random() % 350;
    y = arc4random() % 550 + 100;
    r = arc4random() % 40 + 60;
    if ((x + r * 2) > 375 ) {
        x = (375 - 2 * r);
    }
    if ((y + 2 * r) > 667) {
        y = (667 - 2 * r);
    }
    self.frame = CGRectMake(x, y, r, r);
    self.layer.cornerRadius = r/2;
    self.location = pow(pow(x + r, 2) + pow(y + r, 2), 1/2);

    
}

-(void)animated{
    [UIView animateWithDuration:2.0 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        [self autoLocated];
    } completion:^(BOOL finished) {
        nil;
    }];
}
-(void)autoColored{
    float red,green,blue;
    red = (arc4random() % 100)/100.0;
    green = (arc4random() % 100)/100.0;
    blue = (arc4random() % 100)/100.0;
    [self setBackgroundColor:[UIColor colorWithRed:red green:green blue:blue alpha:0.3]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
