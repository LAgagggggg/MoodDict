//
//  KeyWordButton.h
//  MoodDict
//
//  Created by Shawn on 2018/2/6.
//  Copyright © 2018年 李嘉银. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyWordButton : UIButton
@property  double  location;
@property(nonatomic, strong) NSString * name;

-(void)autoLocated;

@end
