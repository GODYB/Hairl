//
//  SignupViewController.m
//  造型
//
//  Created by 冰刀画的圈。 on 15/9/20.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import "SignupViewController.h"
#import "PrefixHeader.pch"
@interface SignupViewController ()
- (IBAction)sianup:(UIButton *)sender forEvent:(UIEvent *)event;//注册

- (IBAction)back:(UIBarButtonItem *)sender;
@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BJ-3"]];
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

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (IBAction)sianup:(UIButton *)sender forEvent:(UIEvent *)event {
    NSString *username = _username.text;
    NSString *email = _email.text;
    NSString *password = _password.text;
    NSString *confirmPwd = _confirmPwd.text;
    
    if ([username isEqualToString:@""] || [email isEqualToString:@""] || [password isEqualToString:@""] || [confirmPwd isEqualToString:@""]) {
        [Utilities popUpAlertViewWithMsg:@"请填写所有信息" andTitle:nil];
        return;
    }
    if (![password isEqualToString:confirmPwd]) {
        [Utilities popUpAlertViewWithMsg:@"确认密码必须与密码保持一致" andTitle:nil];
        return;
    }
    
    PFUser *user = [PFUser user];
    user.username = username;
    user.password = password;
    user.email = email;
    
    
    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [aiv stopAnimating];
        if (!error) {
            [Utilities setUserDefaults:@"userName" content:username];
            [[storageMgr singletonStorageMgr] addKeyAndValue:@"signUp" And:@1];
            [self.navigationController popViewControllerAnimated:YES];
        } else if (error.code == 202) {
            [Utilities popUpAlertViewWithMsg:@"该用户名已被使用，请尝试其它名称" andTitle:nil];
        } else if (error.code == 203) {
            [Utilities popUpAlertViewWithMsg:@"该电子邮箱已被使用，请尝试其它名称" andTitle:nil];
        } else if (error.code == 125) {
            [Utilities popUpAlertViewWithMsg:@"该电子邮箱地址为非法地址格式" andTitle:nil];
        } else if (error.code == 100) {
            [Utilities popUpAlertViewWithMsg:@"网络不给力，请稍后再试" andTitle:nil];
        } else {
            [Utilities popUpAlertViewWithMsg:nil andTitle:nil];
        }
    }];

}//注册

- (IBAction)back:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];//返回代码
}
@end
