//
//  FirstKeywordViewController.m
//  MoodDict
//
//  Created by Shawn on 2018/2/7.
//  Copyright © 2018年 李嘉银. All rights reserved.
//

#import "FirstKeywordViewController.h"
#import <Masonry.h>
#import "DataBase.h"
#import "KeyWordButton.h"


@interface FirstKeywordViewController ()<CAAnimationDelegate>

@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) NSDictionary * keyWordDict;
@property (nonatomic, strong) UINavigationBar * navigationBar;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) KeyWordButton * test;
// dataArr 用于存放关键字

@end

@implementation FirstKeywordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigation];
    [self loadData];
    [self KeywordButtonInit];
    

    // Do any additional setup after loading the view.
}

-(void)setNameOfBar:(NSString *)name{
    
    self.naviBarTitle = [[UINavigationItem alloc] init];
    self.naviBarTitle.title = name;
    [self.navigationBar pushNavigationItem: self.naviBarTitle animated:YES];
    [self.view addSubview:self.navigationBar];
    [self.navigationBar setItems:[NSArray arrayWithObject: self.naviBarTitle]];

}


-(void)setNavigation{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 25, screenRect.size.width, 50)];

    [self.view addSubview: self.navigationBar];
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    [backBtn addTarget:self action:@selector(btnPressed) forControlEvents:UIControlEventTouchUpInside];
    
    self.naviBarTitle.leftBarButtonItem = item;

}

-(void)btnPressed{
    [self dismissViewControllerAnimated:true completion:nil];
}
-(void)loadData{
    
    self.dataArr = [[DataBase sharedDataBase] setFirstKeyword:self.name];
}
-(void)KeywordButtonInit{
    for ( int i = 0; i < self.dataArr.count; i++) {
        KeyWordButton * btn = [[KeyWordButton alloc] init];
        [btn setName:self.dataArr[i]];
        [btn setTitle:self.dataArr[i] forState:UIControlStateNormal];
        
        [self.view addSubview:btn];
        
    }

}
-(void)animated{

    
    [UIView animateWithDuration:2.0f delay:0 options:UIViewAnimationOptionAutoreverse animations:^{
        [self.test autoLocated];
    } completion:^(BOOL finished) {
        nil;
    }];
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:1.0f];
//    [self.test autoLocated];
//    [UIView commitAnimations];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
