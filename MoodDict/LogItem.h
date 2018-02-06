//
//  LogItem.h
//  MoodDict
//
//  Created by LAgagggggg on 05/02/2018.
//  Copyright © 2018 李嘉银. All rights reserved.
//
enum Mood{shame=0,sad,fear,anxious,angry,disgust,peace,sympathize,interested,delight};

#import <Foundation/Foundation.h>

@interface LogItem : NSObject<NSCoding>
@property NSDate* createdDate;
@property NSString * content;
@property enum Mood mood;
-(instancetype)initWithCoder:(NSCoder *)aDecoder;
-(void)encodeWithCoder:(NSCoder *)aCoder;
@end
