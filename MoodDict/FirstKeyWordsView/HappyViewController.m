//
//  HappyViewController.m
//  MoodDict
//
//  Created by Shawn on 2018/2/6.
//  Copyright © 2018年 李嘉银. All rights reserved.
//

#import "HappyViewController.h"
#import <Masonry.h>
#import "KeyWordButton.h"
@interface HappyViewController ()

@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) KeyWordButton * testButton;
@property (nonatomic, strong) NSDictionary * keyWordDict;

@end

@implementation HappyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigation];
    self.testButton = [[KeyWordButton alloc] init];
    [self.view addSubview:self.testButton] ;
}

-(void)setNavigation{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 25, screenRect.size.width, 50)];

    UINavigationItem * navigationBarTitle = [[UINavigationItem alloc] initWithTitle:@"开心"];
    [navigationBar pushNavigationItem: navigationBarTitle animated:YES];
    [self.view addSubview: navigationBar];

    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    [backBtn addTarget:self action:@selector(btnPressed) forControlEvents:UIControlEventTouchUpInside];

    navigationBarTitle.leftBarButtonItem = item;
    [navigationBar setItems:[NSArray arrayWithObject: navigationBarTitle]];
}

-(void)btnPressed{
    [self dismissViewControllerAnimated:true completion:nil];
}
-(void)keyWordDictInit{
    
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
