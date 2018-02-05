//
//  FirstViewController.h
//  MoodDict
//
//  Created by LAgagggggg on 05/02/2018.
//  Copyright © 2018 李嘉银. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "SideMenuView.h"

@interface DictViewController : UIViewController<UIGestureRecognizerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

-(void)doCallSideMenu;
@end

