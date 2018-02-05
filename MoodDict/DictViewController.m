//
//  FirstViewController.m
//  MoodDict
//
//  Created by LAgagggggg on 05/02/2018.
//  Copyright © 2018 李嘉银. All rights reserved.
//
#define animationDURATION 0.4

#import "DictViewController.h"
#import "CommonButton.h"

@interface DictViewController ()
@property(strong,nonatomic)SideMenuView * pullMenuView;
@property(strong,nonatomic)UIImage * myIcon;
@property (weak, nonatomic) IBOutlet UINavigationBar *naviBar;
@property(strong,nonatomic)UIView * mainWrapperView;
@property(strong, nonatomic) CommonButton * happyBtn;
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

-(void)setUpButton{
    CGSize btnSize = CGSizeMake(130, 66);
    self.happyBtn = [[CommonButton alloc] init];
    [self.happyBtn setTitle:@"开心" forState:UIControlStateNormal];
    [self.view addSubview:self.happyBtn];
    [self.happyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(btnSize);
        make.top.equalTo(self.view).with.offset(145);
        make.left.equalTo(self.view).with.offset(30);
    }];
    
}

-(void)QuitLogin{
    NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
    [defaults setBool:NO forKey:@"loginSuccessJudge"];
    self.loginJudege=NO;
    self.pullMenuView.userInteractionEnabled=NO;
}

@end
