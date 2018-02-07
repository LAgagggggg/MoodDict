//
//  ShowMoodView.m
//  MoodDict
//
//  Created by LAgagggggg on 07/02/2018.
//  Copyright © 2018 李嘉银. All rights reserved.
//
#define pointInterval 30
#import "ShowMoodView.h"

@implementation ShowMoodView

-(void)DrawWithArr:(NSMutableArray<LogItem *> *)arr{
    if (arr.count) {
        CGFloat curX=5;
        CGFloat curY=(1-arr[0].mood/10.f)*self.frame.size.height;
        CGPoint curP=CGPointMake(curX, curY);
        [self.path moveToPoint:curP];
        self.path=[UIBezierPath bezierPath];
        for (LogItem * item in arr) {
            curY=(1-item.mood/10.f)*self.frame.size.height;
            curP=CGPointMake(curX, curY);
            [self.path addLineToPoint:curP];
            [self.path addArcWithCenter:curP radius:5 startAngle:0 endAngle:2*M_PI clockwise:YES];
            [self.path moveToPoint:curP];
            curX+=pointInterval;
        }
    }
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect{
    [self.path fill];
}
@end
