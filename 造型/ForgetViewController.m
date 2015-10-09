//
//  ForgetViewController.m
//  造型
//
//  Created by 冰刀画的圈。 on 15/9/20.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import "ForgetViewController.h"
#import "PrefixHeader.pch"
@interface ForgetViewController ()
- (IBAction)back:(UIBarButtonItem *)sender;
- (IBAction)foundBack:(UIButton *)sender forEvent:(UIEvent *)event;

@end

@implementation ForgetViewController

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

- (IBAction)back:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];//返回代码
    }

/**
 **  邮箱验证
 */

- (IBAction)foundBack:(UIButton *)sender forEvent:(UIEvent *)event {
//    NSLog(@"12416456465");
    NSString *username = _username.text;
    NSString *email = _email.text;

 // 邮箱的格式输入
    NSString *emailCheck = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
     //  转为正则表达式
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailCheck];
//     [emailTest evaluateWithObject:email]; 判定条件 正则表达式的转入
    
    
//    if ([username isEqualToString: nil] || [email isEqualToString: nil]) {
//        [Utilities popUpAlertViewWithMsg:@"请填写所有信息" andTitle:nil];
//        UIAlertView *alert  = [[UIAlertView alloc]initWithFrame:<#(CGRect)#>]
    
    //判断输入的是否为空
    if ([username isEqualToString:@""]||[email isEqualToString:@""])
    {
    
     [Utilities popUpAlertViewWithMsg:@"请填写信息" andTitle:nil];
     return;
    }
     // 判断邮箱格式
   if (![emailTest evaluateWithObject:email]) {
       [Utilities popUpAlertViewWithMsg:@"输入的邮箱不正确" andTitle:nil];
   }
     // 发送邮箱
   else
   {
       [PFUser requestPasswordResetForEmailInBackground:@"932220954@qq.com"];
       [Utilities popUpAlertViewWithMsg:@"密码重置信息已发送至您的邮箱，请修改后在登陆！" andTitle:nil];

   }
    

}
@end
