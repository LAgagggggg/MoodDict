//
//  CommonButton.m
//  MoodDict
//
//  Created by Shawn on 2018/2/5.
//  Copyright © 2018年 李嘉银. All rights reserved.
//

#import "CommonButton.h"
#import <Masonry.h>
#import "FirstKeywordViewController.h"
#import "DataBase.h"
#import "KeyWordButton.h"

@implementation CommonButton

// 一级关键词 

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
    [self addTarget:self action:@selector(btnPressed) forControlEvents:UIControlEventTouchUpInside];

}

-(void)btnPressed{
    FirstKeywordViewController * VC = [[FirstKeywordViewController alloc] init];
    [VC setName:self.keyword];
    [VC setNameOfBar:self.keyword];
    id responder = self.nextResponder;
    while (![responder isKindOfClass: [UIViewController class]] && ![responder isKindOfClass: [UIWindow class]])
    {
        responder = [responder nextResponder];
    }
    if ([responder isKindOfClass: [UIViewController class]])
    {
        [responder presentViewController:VC animated:YES completion:nil];

    }

}




/*
 
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
