//
//  SecondViewController.m
//  MoodDict
//
//  Created by LAgagggggg on 05/02/2018.
//  Copyright © 2018 李嘉银. All rights reserved.
//
#define lightBlueColor [UIColor colorWithRed:108/255. green:227/255. blue:228/255. alpha:1]
#define animationDURATION 0.4

char TitleOfMood[10][10]={"快乐","兴趣","共情","平静","厌恶","愤怒","焦虑","恐惧","悲伤","羞愧"};

#import "LogViewController.h"

@interface LogViewController ()
@property(strong,nonatomic)DictViewController * dictVc;
@property(strong,nonatomic)UIScrollView * graphView;
@property(strong,nonatomic)UIView * displayView;
@property(strong,nonatomic)NSMutableArray<LogItem *> * logItemArr;
@property(strong,nonatomic) NSString * archiverPath;
@property(strong,nonatomic) UIButton * addBtn;
@property(strong,nonatomic) UIButton * checkBtn;
@property(strong,nonatomic) UITextView * inputView;
@property(strong,nonatomic) UIPickerView * pickV;
@end

@implementation LogViewController

-(NSMutableArray *)logItemArr{
    if (_logItemArr==nil) {
        NSString* documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        self.archiverPath=[documentPath stringByAppendingPathComponent:@"MoodData.data"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if([fileManager fileExistsAtPath:self.archiverPath]){
            NSLog(@"file detected");
            _logItemArr=[NSKeyedUnarchiver unarchiveObjectWithFile:self.archiverPath];
        }
        else{
            _logItemArr=[[NSMutableArray alloc]init];
        }
    }
    return  _logItemArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dictVc=self.tabBarController.viewControllers[0];
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]init];//emmm用来取消编辑
    tap.delegate=self;
    [self.view addGestureRecognizer:tap];
    //趋势图
    self.graphView=[[UIScrollView alloc]init];
    [self.view addSubview:self.graphView];
    [self.graphView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).with.offset(64);
        make.height.equalTo(@(250));
    }];
    self.graphView.backgroundColor=[UIColor darkGrayColor];
    //下方编辑区域
    self.displayView=[[UIView alloc]init];
    [self.view addSubview:self.displayView];
    [self.displayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(36);
        make.right.equalTo(self.view.mas_right).with.offset(-36);
        make.top.equalTo(self.graphView.mas_bottom).with.offset(64);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-113);
    }];
    self.displayView.backgroundColor=[UIColor lightGrayColor];
    self.displayView.layer.cornerRadius=10.f;
    //添加按钮
    self.addBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [self.addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [self.displayView addSubview:self.addBtn];
    self.addBtn.tintColor=lightBlueColor;
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.displayView.mas_centerX);
        make.centerY.equalTo(self.displayView.mas_centerY);
        make.height.equalTo(@(100));
        make.width.equalTo(self.addBtn.mas_height);
    }];
    [self.addBtn addTarget:self action:@selector(addLog) forControlEvents:UIControlEventTouchUpInside];
    //添加文本框
    self.inputView=[[UITextView alloc]init];
    [self.displayView addSubview:self.inputView];
    [self.inputView setFont:[UIFont systemFontOfSize:15]];
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.displayView.mas_left).with.offset(20);
        make.right.equalTo(self.displayView.mas_right).with.offset(-20);
        make.top.equalTo(self.displayView.mas_top).with.offset(10);
        make.bottom.equalTo(self.displayView.mas_bottom).with.offset(-10);
    }];
    self.inputView.backgroundColor=[UIColor clearColor];
    [self.inputView setHidden:YES];
    //选择心情
    self.pickV=[[UIPickerView alloc]init];
    [self.displayView addSubview:self.pickV];
    self.pickV.backgroundColor=[UIColor clearColor];
    self.pickV.delegate=self;
    self.pickV.dataSource=self;
    [self.pickV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.displayView.mas_left).with.offset(20);
        make.right.equalTo(self.displayView.mas_right).with.offset(-20);
        make.top.equalTo(self.displayView.mas_top).with.offset(10);
        make.bottom.equalTo(self.displayView.mas_bottom).with.offset(-10);
    }];
    self.pickV.alpha=0;
}

-(void)addLog{
    [UIView animateWithDuration:animationDURATION animations:^{
        self.addBtn.alpha=0;
        self.pickV.alpha=1;
    }];
    self.checkBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [self.checkBtn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    [self.checkBtn addTarget:self action:@selector(Check) forControlEvents:UIControlEventTouchUpInside];
    [self.displayView addSubview:self.checkBtn];
    self.checkBtn.tintColor=lightBlueColor;
    [self.checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.displayView.mas_right).with.offset(-5);
        make.top.equalTo(self.displayView.mas_top).with.offset(5);
        make.width.equalTo(@(40));
        make.height.equalTo(self.checkBtn.mas_width);
    }];
//    [self.inputView setHidden: NO];
}

-(void)Check{
    [UIView animateWithDuration:animationDURATION animations:^{
        self.pickV.alpha=0;
    }];
    [self.inputView setHidden:NO];
    [self.inputView becomeFirstResponder];
    [self.checkBtn removeFromSuperview];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    //设置注销输入
    if(![touch.view isDescendantOfView:self.displayView]){
        [self.inputView resignFirstResponder];
        [self.inputView setHidden:YES];
        [UIView animateWithDuration:animationDURATION animations:^{
            self.addBtn.alpha=1;
            self.pickV.alpha=0;
        }];
    }
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)PullSideMenu:(id)sender {
    [self.dictVc doCallSideMenu];
}

-(void)saveData{
    [NSKeyedArchiver archiveRootObject:self.logItemArr toFile:self.archiverPath];
}

//选择心情
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 10;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString * title=[NSString stringWithCString:TitleOfMood[row] encoding:NSUTF8StringEncoding];
    return title;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"%ld",row);
}

@end
