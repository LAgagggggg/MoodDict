//
//  FirstKeywordViewController.h
//  MoodDict
//
//  Created by Shawn on 2018/2/7.
//  Copyright © 2018年 李嘉银. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstKeywordViewController : UIViewController
@property (nonatomic, strong) UINavigationItem * naviBarTitle;
@property (nonatomic, strong) NSString * name;


-(void)setNameOfBar:(NSString *)name;


@end


