//
//  LoginViewController.m
//  造型
//
//  Created by 冰刀画的圈。 on 15/9/20.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import "LoginViewController.h"
#import "PrefixHeader.pch"
#import "TabViewController.h"
@interface LoginViewController ()
- (IBAction)login:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)return:(UIBarButtonItem *)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    /**
    **  保存用户名
    */
    
    if (![[Utilities getUserDefaults:@"username"] isKindOfClass:[NSNull class]]) {
        _username.text = [Utilities getUserDefaults:@"username"];

}
     self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BJ-3"]];
}


/**
 **  判断数据库的验证
 */

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];//超类进行判断
    

    if ([[[storageMgr singletonStorageMgr]objectForKey:@"signup"]integerValue]==1) {
        [[storageMgr singletonStorageMgr]removeObjectForKey:@"signup"];
        
        
      
    }
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

/**
 **  上传数据 验证登录
 */

- (IBAction)login:(UIButton *)sender forEvent:(UIEvent *)event {
    
    NSString *username = _username.text;
    NSString *password = _password.text;
    
    if ([username isEqualToString:@""] || [password isEqualToString:@""])
    {
        [Utilities popUpAlertViewWithMsg:@"请填写所有信息" andTitle:nil];
        return;
    }
    
    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
//    [SVProgressHUD show];

    //登录的方法
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error)
     {
//         [SVProgressHUD dismiss];
         [aiv stopAnimating];
         if (user)
         {
             //登录成功后保存 下次自动登录
             [Utilities setUserDefaults:@"username" content:username];
             
 
                 [Utilities setUserDefaults:@"password" content:password];
             //返回上个界面
             [self dismissViewControllerAnimated:YES completion:nil];
         }
         else if (error.code == 101)
         {
             [Utilities popUpAlertViewWithMsg:@"用户名或密码错误" andTitle:nil];
         }
         else if (error.code == 100)
         {
             
             [Utilities popUpAlertViewWithMsg:@"网络不给力，请稍后再试" andTitle:nil];
         }
         else
         {
             [Utilities popUpAlertViewWithMsg:nil andTitle:nil];
         }
     }];
    



}

- (IBAction)return:(UIBarButtonItem *)sender {
       [self dismissViewControllerAnimated:YES completion:nil];
}

/*键盘回收*/
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    [theTextField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
@end
