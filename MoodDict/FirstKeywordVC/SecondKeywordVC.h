//
//  SecondKeywordVC.h
//  MoodDict
//
//  Created by Shawn on 2018/2/8.
//  Copyright © 2018年 李嘉银. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondKeywordVC : UIViewController
@property (nonatomic, strong) UINavigationItem * naviBarTitle;
@property (nonatomic, strong) NSString * name;

-(void)setNameOfBar:(NSString *)name;


@end
