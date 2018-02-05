//
//  SecondViewController.m
//  MoodDict
//
//  Created by LAgagggggg on 05/02/2018.
//  Copyright © 2018 李嘉银. All rights reserved.
//

#import "LogViewController.h"

@interface LogViewController ()
@property(strong,nonatomic)DictViewController * dictVc;
@end

@implementation LogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dictVc=self.tabBarController.viewControllers[0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)PullSideMenu:(id)sender {
    [self.dictVc doCallSideMenu];
}

@end
