//
//  SecondKeywordVC.m
//  MoodDict
//
//  Created by Shawn on 2018/2/8.
//  Copyright © 2018年 李嘉银. All rights reserved.
//

#import "SecondKeywordVC.h"

@interface SecondKeywordVC ()
@property (nonatomic, strong) UINavigationBar * navigationBar;
@property (nonatomic, strong) UILabel * labelSource;
@property (nonatomic, strong) UITextView * text;


@end

@implementation SecondKeywordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView * lineFirst = [[UIView alloc] initWithFrame:CGRectMake(15, 115, 335, 1)];
    lineFirst.backgroundColor = [UIColor grayColor];
    [self.view addSubview:lineFirst];
    [self setNavigation];
    self.labelSource = [[UILabel alloc] initWithFrame:CGRectMake(15, 80, 60, 40)];
    [self.labelSource setFont:[UIFont systemFontOfSize:20]];
    [self.labelSource setText:@"来源"];
    [self.view addSubview:self.labelSource];
    [self setUpTextView];
    [self.view addSubview:self.text];
    
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
-(void) setUpTextView{
    self.text = [[UITextView alloc] initWithFrame:CGRectMake(15, 118, 335, 500)];
    
    self.text.textColor = [UIColor blackColor];
    self.text.font = [UIFont systemFontOfSize:18.0];
    self.text.textAlignment = NSTextAlignmentJustified;
    
    
    
    
    
}
-(void)btnPressed{
    [self dismissViewControllerAnimated:true completion:nil];
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
