//
//  ShowMoodView.h
//  MoodDict
//
//  Created by LAgagggggg on 07/02/2018.
//  Copyright © 2018 李嘉银. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogItem.h"

@interface ShowMoodView : UIView
@property(nonatomic,strong)UIBezierPath *path;
-(void)DrawWithArr:(NSMutableArray *)arr;
@end
