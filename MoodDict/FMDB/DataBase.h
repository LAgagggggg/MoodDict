//
//  DataBase.h
//  MoodDict
//
//  Created by Shawn on 2018/2/7.
//  Copyright © 2018年 李嘉银. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>

@interface DataBase : NSObject

+(instancetype) sharedDataBase;

-(NSMutableArray *)setFirstKeyword:(NSString *)keyword;

//-(void)setUpHappyTable;
//-(void)setUpSorrowTable;
//-(void)setUpEmpathyTable;
//-(void)setUpDisgustTable;
//-(void)setUpPeaceTable;
//-(void)setUpAngerTable;
//-(void)setUpShameTable;
//-(void)setUpInterestTable;
//-(void)setUpFrightenTable;
//-(void)setUpAnxietyTable;
@end
