//
//  DataBase.m
//  MoodDict
//
//  Created by Shawn on 2018/2/7.
//  Copyright © 2018年 李嘉银. All rights reserved.
//

#import "DataBase.h"
static DataBase * _DBCtl = nil;
@interface DataBase()<NSCopying, NSMutableCopying>{
    FMDatabase * _db;
    
}
@end

@implementation DataBase


+(instancetype)sharedDataBase{
    if (_DBCtl == nil) {
        _DBCtl = [[DataBase alloc] init];
        [_DBCtl initDataBase];
    }
    return _DBCtl;
    
}
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    if (_DBCtl == nil) {
        _DBCtl = [super allocWithZone:zone];
    }
    return _DBCtl;
}
-(id)copy{
    
    return self;
    
}

-(id)mutableCopy{
    
    return self;
    
}

-(id)copyWithZone:(NSZone *)zone{
    
    return self;
    
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    
    return self;
    
}

-(void)initDataBase{
    // 获得Documents目录路径

    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 文件路径
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"keyword.sqlite"];
    
    _db = [FMDatabase databaseWithPath:filePath];
    
    BOOL result = [_db open];
    
    if (result) {
        NSLog(@"Success!");
    }else{
        NSLog(@"Error");
    }
    // 初始化数据表
    NSString * happyKeyword = @"CREATE TABLE 'happykeyword' ('keyword' TEXT, 'definition' TEXT, 'source' TEXT)";
    NSString * sorrowKeyword = @"CREATE TABLE 'sorrowkeyword' ('keyword' TEXT, 'definition' TEXT, 'source' TEXT)";
    NSString * empathyKeyword = @"CREATE TABLE 'empathykeyword' ('keyword' TEXT, 'definition' TEXT, 'source' TEXT)";
    NSString * disgustKeyword = @"CREATE TABLE 'disgustkeyword' ('keyword' TEXT, 'definition' TEXT, 'source' TEXT)";
    NSString * peaceKeyword = @"CREATE TABLE 'peacekeyword' ('keyword' TEXT, 'definition' TEXT, 'source' TEXT)";
    NSString * angerKeyword = @"CREATE TABLE 'angerkeyword' ('keyword' TEXT, 'definition' TEXT, 'source' TEXT)";
    NSString * shameKeyword = @"CREATE TABLE 'shamekeyword' ('keyword' TEXT, 'definition' TEXT, 'source' TEXT)";
    NSString * interestKeyword = @"CREATE TABLE 'interestkeyword' ('keyword' TEXT, 'definition' TEXT, 'source' TEXT)";
    NSString * frightenKeyword = @"CREATE TABLE 'frightenkeyword' ('keyword' TEXT, 'definition' TEXT, 'source' TEXT)";
    NSString * anxietyKeyword = @"CREATE TABLE 'anxietykeyword' ('keyword' TEXT, 'definition' TEXT, 'source' TEXT)";

    
    [_db executeUpdate:happyKeyword];
    [_db executeUpdate:sorrowKeyword];
    [_db executeUpdate:empathyKeyword];
    [_db executeUpdate:disgustKeyword];
    [_db executeUpdate:peaceKeyword];
    [_db executeUpdate:angerKeyword];
    [_db executeUpdate:shameKeyword];
    [_db executeUpdate:interestKeyword];
    [_db executeUpdate:frightenKeyword];
    [_db executeUpdate:anxietyKeyword];
    
    [_db close];

}

-(void)setUpHappyTable{
    NSArray * happyKeywordArray = [[NSArray alloc] initWithObjects:
                            @"以子为荣",@"撒娇依赖",@"幸灾乐祸",@"自豪",@"欢乐",@"无忧无虑",@"怜爱情节",@"满意",
                            @"自信",@"期待",@"自以为是",@"勇气",@"满足",@"获胜之喜",@"不设防",@"欣喜",@"偷懒之乐",
                            @"如释重负",@"狂喜",@"温馨",@"自我感觉良好" ,@"欣快",@"温情",@"高兴",@"感恩",@"归家之喜",
                            @"幸福",@"爱",@"随喜赞叹",@"激昂",@"充满希望",@"安居乐业",@"快乐",nil];
    [_db open];
    NSString * excuteStr = @"INSERT INTO happykeyword(keyword)VALUES(?)";
    for (int i = 0; i < happyKeywordArray.count; i++) {
        [_db executeUpdate:excuteStr, happyKeywordArray[i] ];
    }
    NSMutableArray * array = [[NSMutableArray alloc] init];
    FMResultSet * res = [_db executeQuery:@"SELECT * FROM happyKeyword"];
    while ([res next]) {
        NSString * tempstring = [[NSString alloc] init];
        tempstring = [res stringForColumn:@"keyword"];
        [array addObject:tempstring];
    }
    for (int i = 0; i < array.count; i++) {
        NSLog(@"%@",array[i]);
    }
    
    [_db close];
}

-(void)setUpSorrowTable{
    NSArray * sorrowKeywordArray = [[NSArray alloc] initWithObjects:
                                    @"人去心空",@"求子心切",@"安慰",@"脆弱",@"绝望",@"悲天悯人",
                                    @"失望",@"气馁",@"肃穆之感",@"悲痛",@"悲伤",@"沮丧",@"怀旧思乡",
                                    @"乡愁", @"人的顽强",@"物哀",@"忧郁",@"遗憾",@"怜悯",@"懊悔",
                                    @"自怨自艾",@"悲伤",@"惆怅",nil];
    [_db open];
    NSString * excuteStr = @"INSERT INTO sorrowkeyword(keyword)VALUES(?)";
    for (int i = 0; i < sorrowKeywordArray.count; i++) {
        [_db executeUpdate:excuteStr, sorrowKeywordArray[i]];
    }
    [_db close];

}

-(void)setUpEmpathyTable{
    NSArray * empathyKeywordArray = [[NSArray alloc] initWithObjects:@"同情",@"同理心", nil];
    [_db open];
    NSString * excuteStr = @"INSERT INTO empathykeyword(keyword)VALUES(?)";
    for (int i = 0; i < empathyKeywordArray.count; i++) {
        [_db executeUpdate:excuteStr, empathyKeywordArray[i]];
    }
    [_db close];
}

-(void)setUpDisgustTable{
    NSArray * disgustKeywordArray = [[NSArray alloc] initWithObjects:@"倦怠",@"厌倦",@"不满",@"厌恶",@"不耐烦",@"乖戾",@"蔑视", nil];
    [_db open];
    NSString * excuteStr = @"INSERT INTO disgustkeyword(keyword)VALUES(?)";
    for (int i = 0; i < disgustKeywordArray.count; i++) {
        [_db executeUpdate:excuteStr, disgustKeywordArray[i]];
    }
    [_db close];
}
-(void)setUpPeaceTable{
    
    NSArray * peaceKeywordArray = [[NSArray alloc] initWithObjects:@"冷静",@"隐忍", nil];
    [_db open];
    NSString * excuteStr = @"INSERT INTO peacekeyword(keyword)VALUES(?)";
    for (int i = 0; i < peaceKeywordArray.count; i++) {
        [_db executeUpdate:excuteStr,peaceKeywordArray[i]];
    }
    [_db close];
    
}

-(void)setUpAngerTable{
    
    NSArray * angerKeywordArray = [[NSArray alloc] initWithObjects:
                                   @"由爱生恨",@"非解释清楚不可",@"怀恨在心",@"气恼",@"激怒",@"义愤",@"满腔怒火",@"仇恨",@"恼怒",@"被侮辱",
                                   @"起床气",@"有点气恼",@"化愤怒为力量",@"羞愤",@"狂怒",@"突然恼怒",@"愤愤不平",@"路怒",@"责备",@"技术应激",@"烦躁",@"复仇", nil];
    [_db open];
    NSString * excuteStr = @"INSERT INTO angerkeyword(keyword)VALUES(?)";
    for (int i = 0; i < angerKeywordArray.count; i++) {
        [_db executeUpdate:excuteStr,angerKeywordArray[i]];
    }
    [_db close];
}

-(void)setUpShameTable{
    NSArray * shameKeywordArray = [[NSArray alloc] initWithObjects:@"尴尬",@"怕麻烦别人",@"内疚",@"羞辱",@"自惭形秽",@"替人脸红",@"羞耻",@"亏欠感", nil];
    [_db open];
    NSString * excuteStr = @"INSERT INTO shamekeyword(keyword)VALUES(?)";
    for (int i = 0; i < shameKeywordArray.count; i++) {
        [_db executeUpdate:excuteStr,shameKeywordArray[i]];
    }
}
-(void)setUpInterestTable{
    NSArray * interestKeywordArray = [[NSArray alloc] initWithObjects:
                                      @"酷炫",@"情欲",@"猎奇",@"废物迷恋",@"漫游欲",@"作死",@"远方向往",@"兴趣",@"惊奇",@"亲吻渴望",
                                      @"热望",@"多元之爱",@"收藏欲",@"好奇",@"欲望",@"激动",nil];
    [_db open];
    NSString * excuteStr = @"INSERT INTO interestkeyword(keyword)VALUES(?)";
    for (int i = 0; i < interestKeywordArray.count; i++) {
        [_db executeUpdate:excuteStr,interestKeywordArray[i]];
    }
    [_db close];
    
}

-(void)setUpFrightenTable{
    NSArray * frightenKeywordArray = [[NSArray alloc] initWithObjects:
                                      @"孤独", @"望眼欲穿", @"怕鬼", @"虚空的呼唤", @"惊骇", @"震惊", @"惊讶",@"惊吓",@"不知所措",@"幽闭恐惧",@"恐惧",@"低声下气",
                                      @"神经过敏", @"像个冒牌者", @"惧怕", @"恐慌",@"避世", nil];
    [_db open];
    NSString * excuteStr = @"INSERT INTO frightenkeyword(keyword)VALUES(?)";
    for (int i = 0; i < frightenKeywordArray.count; i++) {
        [_db executeUpdate:excuteStr, frightenKeywordArray[i]];
    }
    

    
    [_db close];
    
}
-(void)setUpAnxietyTable{
    NSArray * anxietyKeywordArray = [[NSArray alloc] initWithObjects:
                                     @"不确定",@"时间焦虑",@"异境茫然",@"饥饿",@"紧张",@"肠胃焦虑",@"网络自诊焦虑",
                                     @"不堪重负",@"妄想",@"多疑",@"暴躁",@"勉强",@"手机幻听",@"竞争",@"妒忌",@"忧虑不安",@"迷茫",@"担忧",@"抑郁",@"嫉羡", @"困惑",nil];
    [_db open];
    NSString * excuteStr = @"INSERT INTO anxietykeyword(keyword)VALUES(?)";
    for (int i = 0; i < anxietyKeywordArray.count; i++) {
        [_db executeUpdate:excuteStr, anxietyKeywordArray[i]];
    }
}



-(NSMutableArray *)setFirstKeyword:(NSString *)keyword{
    // 传入happykeyword sorrow等
    [_db open];
    
    NSMutableArray * array = [[NSMutableArray alloc] init];
    
    FMResultSet * res = [FMResultSet alloc];

    if ([keyword isEqualToString:@"快乐"]) {
        res = [_db executeQuery:@"SELECT * FROM happykeyword"];
    }
    else if ([keyword isEqualToString:@"悲伤"]){
        res = [_db executeQuery:@"SELECT * FROM sorrowkeyword"];
    }
    else if ([keyword isEqualToString:@"共情"]){
        res = [_db executeQuery:@"SELECT * FROM empathykeyword"];
    }
    else if ([keyword isEqualToString: @"厌恶"]){
        res = [_db executeQuery:@"SELECT * FROM disgustkeyword"];
    }
    else if ([keyword isEqualToString:@"平静"]){
         res = [_db executeQuery:@"SELECT * FROM peacekeyword"];
    }
    else if ([keyword isEqualToString:@"愤怒"]){
        res = [_db executeQuery:@"SELECT * FROM angerkeyword"];
    }
    else if ([keyword isEqualToString:@"羞愧"]){
      res = [_db executeQuery:@"SELECT * FROM shamekeyword"];
    }
    else if ([keyword isEqualToString:@"兴趣"]){
         res = [_db executeQuery:@"SELECT * FROM interestkeyword"];
    }
    else if ([keyword isEqualToString:@"恐惧"]){
         res = [_db executeQuery:@"SELECT * FROM frightenkeyword"];
    }
    else if ([keyword isEqualToString:@"焦虑"]){
         res = [_db executeQuery:@"SELECT * FROM anxietykeyword" ];
    }
    while ([res next]) {
        NSString * tempstring = [[NSString alloc] init];
        tempstring = [res stringForColumn:@"keyword"];
        [array addObject:tempstring];
    }
//    for (int i = 0; i < array.count; i++) {
//        NSLog(@"%@", array[i]);
//    }
    [_db close];
    
    return array;
}


@end
