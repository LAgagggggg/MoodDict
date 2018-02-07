//
//  CommonButton.h
//  MoodDict
//
//  Created by Shawn on 2018/2/5.
//  Copyright © 2018年 李嘉银. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonButton : UIButton
@property (nonatomic, strong) NSString * keyword; // 一级关键词
@property (nonatomic, strong) NSMutableArray * dataArr;// 存储关键字
-(void) setUpButton;

@end
