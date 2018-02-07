//
//  FirstViewController.m
//  MoodDict
//
//  Created by LAgagggggg on 05/02/2018.
//  Copyright © 2018 李嘉银. All rights reserved.
//
#define animationDURATION 0.4
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height

#define BUTTON_LEFT_FACTOR 30/[UIScreen mainScreen].bounds.size.width
#define BUTTON_TOP_FACTOR 145/[UIScreen mainScreen].bounds.size.height
#define BUTTON_RIGHT_FACTOR -30/[UIScreen mainScreen].bounds.size.width


#define BUTTON_WIDTH_FACTOR 130/[UIScreen mainScreen].bounds.size.width
#define BUTTON_HEIGHT_FACTOR 66/[UIScreen mainScreen].bounds.size.height


#import "DictViewController.h"
#import "CommonButton.h"
#import "FirstKeywordViewController.h"

#import "DataBase.h"

@interface DictViewController ()
@property(strong,nonatomic)SideMenuView * pullMenuView;
@property(strong,nonatomic)UIImage * myIcon;
@property (weak, nonatomic) IBOutlet UINavigationBar *naviBar;
@property(strong,nonatomic)UIView * mainWrapperView;

@property(strong, nonatomic) CommonButton * happyBtn;
@property(strong, nonatomic) CommonButton * sorrowBtn;
@property(strong, nonatomic) CommonButton * empathyBtn;
@property(strong, nonatomic) CommonButton * disgustBtn;
@property(strong, nonatomic) CommonButton * peaceBtn;
@property(strong, nonatomic) CommonButton * angerBtn;
@property(strong, nonatomic) CommonButton * shameBtn;
@property(strong, nonatomic) CommonButton * interestBtn;
@property(strong, nonatomic) CommonButton * frightenBtn;
@property(strong, nonatomic) CommonButton * anxietyBtn;


@property BOOL loginJudege;


@end

@implementation DictViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]init];//emmm用来取消编辑
    tap.delegate=self;
    [self.tabBarController.view addGestureRecognizer:tap];
    self.mainWrapperView=[[UIView alloc]initWithFrame:self.tabBarController.view.frame];
    [self.tabBarController.view addSubview:self.mainWrapperView];
    self.myIcon=[UIImage imageNamed:@"我的"];
    UITapGestureRecognizer * tapToChooseAvatar=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToChooseAvatar:)];
    self.pullMenuView=[[SideMenuView alloc]initWithIcon:self.myIcon andTapGestureRecognizer:tapToChooseAvatar];
    [self.view bringSubviewToFront:self.mainWrapperView];
    self.mainWrapperView.alpha=0;
    [self.tabBarController.view addSubview:self.pullMenuView];
    UIPanGestureRecognizer * pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.pullMenuView addGestureRecognizer:pan];
    [self.pullMenuView.logoutBtn addTarget:self action:@selector(QuitLogin) forControlEvents:UIControlEventTouchUpInside];
    [self setUpButton];


}

-(void)viewDidAppear:(BOOL)animated{
    NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
    self.loginJudege=[defaults boolForKey:@"loginSuccessJudge"];
    if (self.loginJudege==YES) {
        self.pullMenuView.userInteractionEnabled=YES;
    }
    else{
        self.pullMenuView.userInteractionEnabled=NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)PullSideMenu:(id)sender {
    [self doCallSideMenu];
}
-(void)doCallSideMenu{
    if (self.loginJudege) {
        CGRect frame=self.pullMenuView.frame;
        frame.origin.x=0;
        [UIView animateWithDuration:animationDURATION animations:^{
            self.pullMenuView.frame=frame;
            self.mainWrapperView.alpha=0.5;
        }];
    }
    else{
        LoginViewController * vc=[[LoginViewController alloc]init];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage * newAvatar=[info objectForKey:@"UIImagePickerControllerEditedImage"];
    self.myIcon=newAvatar;
    [self.pullMenuView setAvatar:self.myIcon];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)pan:(UIPanGestureRecognizer *)pan{
    CGPoint transP=[pan translationInView:self.pullMenuView];
    if (pan.state==UIGestureRecognizerStateChanged) {
        if (self.pullMenuView.frame.origin.x<=0) {
            self.pullMenuView.transform=CGAffineTransformTranslate(self.pullMenuView.transform, transP.x, 0);
        }
        if(self.pullMenuView.frame.origin.x>0){
            CGRect frame=self.pullMenuView.frame;
            frame.origin.x=0;
            [UIView animateWithDuration:animationDURATION animations:^{
                self.pullMenuView.frame=frame;
            }];
        }
    }
    else if(pan.state==UIGestureRecognizerStateEnded){
        CGRect frame=self.pullMenuView.frame;
        if(self.pullMenuView.frame.origin.x<-self.pullMenuView.setedPushWidth/2){
            frame.origin.x=-self.pullMenuView.setedPushWidth;
        }
        else{
            frame.origin.x=0;
        }
        [UIView animateWithDuration:animationDURATION animations:^{
            self.pullMenuView.frame=frame;
        }];
    }
    CGFloat dimRatio=0.5+(self.pullMenuView.frame.origin.x/-self.pullMenuView.setedPushWidth)*0.5;
    [UIView animateWithDuration:animationDURATION animations:^{
        self.mainWrapperView.alpha=1-dimRatio;
    }];
    [pan setTranslation:CGPointZero inView:self.pullMenuView];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    //设置菜单弹出时点击主界面菜单收回
    if (self.pullMenuView.frame.origin.x!=-self.pullMenuView.setedPushWidth&&![touch.view isDescendantOfView:self.pullMenuView.actualMenuView]) {
        CGRect frame=self.pullMenuView.frame;
        frame.origin.x=-self.pullMenuView.setedPushWidth;
        [UIView animateWithDuration:animationDURATION animations:^{
            self.pullMenuView.frame=frame;
            self.mainWrapperView.alpha=0;
        }];
        return YES;
    }
    return NO;
}

-(void)tapToChooseAvatar:(UITapGestureRecognizer *)tap{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIImagePickerController * library=[[UIImagePickerController alloc]init];
            NSArray * availableType =[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            library.mediaTypes=availableType;
            library.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            library.delegate=self;
            library.allowsEditing=YES;
            [self presentViewController:library animated:YES completion:nil];
        }
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
        PickerImage.allowsEditing = YES;
        PickerImage.delegate = self;
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void) setUpButton{
    CGSize btnSize = CGSizeMake(BUTTON_WIDTH_FACTOR * Screen_Width, BUTTON_HEIGHT_FACTOR * Screen_Height);
    
    self.happyBtn = [[CommonButton alloc] init];
    self.happyBtn.keyword = @"快乐";
    [self.happyBtn setTitle:self.happyBtn.keyword forState:UIControlStateNormal];
    [self.view addSubview:self.happyBtn];
    [self.happyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(btnSize);
        make.top.equalTo(self.view).with.offset(BUTTON_TOP_FACTOR * Screen_Height);
        make.left.equalTo(self.view).with.offset(BUTTON_LEFT_FACTOR * Screen_Width);
    }];
    
    self.sorrowBtn = [[CommonButton alloc] init];
    self.sorrowBtn.keyword = @"悲伤";
    [self.sorrowBtn setTitle:self.sorrowBtn.keyword  forState:UIControlStateNormal];
    [self.view addSubview:self.sorrowBtn];
    [self.sorrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(btnSize);
        make.top.equalTo(self.view).with.offset(BUTTON_TOP_FACTOR * Screen_Height);
        make.right.equalTo(self.view).with.offset(BUTTON_RIGHT_FACTOR * Screen_Width);
    }];
    
    self.empathyBtn = [[CommonButton alloc] init];
    self.empathyBtn.keyword = @"共情";
    [self.empathyBtn setTitle:self.empathyBtn.keyword forState:UIControlStateNormal];
    [self.view addSubview:self.empathyBtn];
    [self.empathyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(btnSize);
        make.top.equalTo(self.happyBtn).with.offset(88);
        make.left.equalTo(self.view).with.offset(BUTTON_LEFT_FACTOR * Screen_Width);
    }];
    
    self.disgustBtn = [[CommonButton alloc] init];
    self.disgustBtn.keyword = @"厌恶";
    [self.disgustBtn setTitle:self.disgustBtn.keyword forState:UIControlStateNormal];
    [self.view addSubview:self.disgustBtn];
    [self.disgustBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(btnSize);
        make.right.equalTo(self.view).with.offset(BUTTON_RIGHT_FACTOR * Screen_Width);
        make.top.equalTo(self.happyBtn).with.offset(88);
    }];
    
    self.peaceBtn = [[CommonButton alloc] init];
    self.peaceBtn.keyword = @"平静";
    [self.peaceBtn setTitle:self.peaceBtn.keyword forState:UIControlStateNormal];
    [self.view addSubview:self.peaceBtn];
    [self.peaceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(btnSize);
        make.left.equalTo(self.view).with.offset(BUTTON_LEFT_FACTOR * Screen_Width);
        make.top.equalTo(self.empathyBtn).with.offset(88);
        
    }];
    
    self.angerBtn = [[CommonButton alloc] init];
    self.angerBtn.keyword = @"愤怒";
    [self.angerBtn setTitle:self.angerBtn.keyword forState:UIControlStateNormal];
    [self.view addSubview:self.angerBtn];
    [self.angerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(btnSize);
        make.right.equalTo(self.view).with.offset(BUTTON_RIGHT_FACTOR * Screen_Width);
        make.top.equalTo(self.empathyBtn).with.offset(88);
    }];
    
    self.shameBtn = [[CommonButton alloc] init];
    self.shameBtn.keyword = @"羞愧";
    [self.shameBtn setTitle:self.shameBtn.keyword forState:UIControlStateNormal];
    [self.view addSubview:self.shameBtn];
    [self.shameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(btnSize);
        make.left.equalTo(self.view).with.offset(BUTTON_LEFT_FACTOR * Screen_Width);
        make.top.equalTo(self.angerBtn).with.offset(88);
    }];
    
    self.interestBtn = [[CommonButton alloc] init];
    self.interestBtn.keyword = @"兴趣";
    [self.interestBtn setTitle:self.interestBtn.keyword forState:UIControlStateNormal];
    [self.view addSubview:self.interestBtn];
    [self.interestBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(btnSize);
        make.right.equalTo(self.view).with.offset(BUTTON_RIGHT_FACTOR * Screen_Width);
        make.top.equalTo(self.angerBtn).with.offset(88);
    }];
    
    self.frightenBtn = [[CommonButton alloc] init];
    self.frightenBtn.keyword = @"恐惧";
    [self.frightenBtn setTitle:self.frightenBtn.keyword forState:UIControlStateNormal];
    [self.view addSubview:self.frightenBtn];
    [self.frightenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(btnSize);
        make.left.equalTo(self.view).with.offset(BUTTON_LEFT_FACTOR * Screen_Width);
        make.top.equalTo(self.shameBtn).with.offset(88);
    }];
    
    self.anxietyBtn = [[CommonButton alloc] init];
    self.anxietyBtn.keyword = @"焦虑";
    [self.anxietyBtn setTitle:self.anxietyBtn.keyword forState:UIControlStateNormal];
    [self.view addSubview:self.anxietyBtn];
    [self.anxietyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(btnSize);
        make.right.equalTo(self.view).with.offset(BUTTON_RIGHT_FACTOR * Screen_Width);
        make.top.equalTo(self.shameBtn).with.offset(88);
    }];
        
}


-(void)QuitLogin{
    NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
    [defaults setBool:NO forKey:@"loginSuccessJudge"];
    self.loginJudege=NO;
    self.pullMenuView.userInteractionEnabled=NO;
}

@end
