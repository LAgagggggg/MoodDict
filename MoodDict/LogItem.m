//
//  LogItem.m
//  MoodDict
//
//  Created by LAgagggggg on 05/02/2018.
//  Copyright © 2018 李嘉银. All rights reserved.
//

#import "LogItem.h"

@implementation LogItem
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self.createdDate = [aDecoder decodeObjectForKey:@"date"];
    self.content = [aDecoder decodeObjectForKey:@"content"];
    self.mood= [aDecoder decodeIntForKey:@"mood"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.createdDate forKey:@"date"];
    [coder encodeObject:self.content forKey:@"content"];
    [coder encodeInt:self.mood forKey:@"mood"];
}

-(BOOL)isLogToday{
    NSDate * today=[[NSDate alloc]init];
    NSString * todayString=[[today description] substringToIndex:10];
    NSString * dateString=[[self.createdDate description]substringToIndex:10];
    if ([dateString isEqualToString:todayString]) {
        return YES;
    }
    else{
        return NO;
    }
}
@end
