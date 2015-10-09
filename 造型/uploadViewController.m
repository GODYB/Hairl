//
//  uploadViewController.m
//  Hair
//
//  Created by ajw on 15/10/8.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import "uploadViewController.h"
#import  "HomeViewController.h"
@interface uploadViewController ()
- (IBAction)timeDate:(UIDatePicker *)sender;
- (IBAction)upload:(UIButton *)sender forEvent:(UIEvent *)event;



@end

@implementation uploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _name.text =_like[@"productName"];
    _timeLi.text =_like[@"producttime"];
    _price.text =_like[@"productPrice"];
    _LikeTime.minimumDate = [NSDate date];
    
}

-(void)viewWillAppear:(BOOL)animated {
    // 单利化全局变量
    
    if ([[[storageMgr singletonStorageMgr] objectForKey:@"background"] integerValue] == 0) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BJ-1"]];
    } else {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BJ-2"]];
        
    }
    [super viewWillAppear:animated];//视图出现之前做的事情
    
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

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
}

//键盘回收   点击return textField
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

//点击空白处  textField
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
//也是键盘回收  textView
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (IBAction)timeDate:(UIDatePicker *)sender {
    
    //date picker 把数据加进TextField里
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm a"];
    //创建字符串
    NSString *astring = [[NSString alloc] init];
    //stringFromDate返回值为字符
    astring = [dateFormatter stringFromDate:sender.date];
    _metime.text=astring;
    
}

- (IBAction)upload:(UIButton *)sender forEvent:(UIEvent *)event {
    NSString *Duration = self.metime.text;
    
    if ([ Duration  isEqualToString:@""])
    {
        [Utilities popUpAlertViewWithMsg:@"请选择时间" andTitle:nil];
        return;
        
    }
    UIAlertView *confirmView = [[UIAlertView alloc]initWithTitle:@"是否确认您的订单" message:@"并返回主页" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [confirmView show];
    
}

/**
 *上传
 */

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
       
//        // 获取指定的Storyboard，name填写Storyboard的文件名
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        // 从Storyboard上按照identifier获取指定的界面（VC），identifier必须是唯一的
//    HomeViewController *receive = [storyboard instantiateViewControllerWithIdentifier:@"IdReceive"];
    
//        
//        [self.navigationController pushViewController:receive animated:YES];
        

    
    [self uploadSten];
    }
}

- (void) uploadSten
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm a"];
    
    NSString *Duration = self.metime.text;
    NSDate* inputDate  = [dateFormatter dateFromString:Duration];
    NSLog(@"%@",inputDate);
    
    NSString *astring = _like[@"productPrice"];
    NSLog(@"%@",astring);
    
    
    //NSString 转 NSNumber 格式
    NSNumberFormatter *numprice = [[NSNumberFormatter alloc] init];
    [numprice setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *numTemp = [numprice numberFromString:astring];
    
    PFObject *Book = [PFObject objectWithClassName:@"Order"];
    Book[@"orderDate"] = inputDate;
    Book[@"orderPrice"] = numTemp;
    Book[@"orderName"] =_like[@"productName"];
    

    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    PFUser *currentUser = [PFUser currentUser];//获取当前用户的实例,创建关联
    Book[@"ouserId"] = currentUser;
    Book[@"oprodictId"]=_like;
    [Book saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
     {
         [aiv stopAnimating];//停止转动
         if (succeeded) {

             [self dismissViewControllerAnimated:YES completion:nil];
             //返回首页 返回上一页
             //[self.navigationController popViewControllerAnimated:YES];//返回上个页面
          
         } else {
             NSLog(@"%@", [error description]);
             [Utilities popUpAlertViewWithMsg:nil andTitle:nil];
         }
         
     }];
    
}




//UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100, 30)]
//textField.returnKeyType = UIReturnKeySearch; //设置按键类型
//textField.enablesReturnKeyAutomatically = YES; //这里设置为无文字就灰色不可点
@end
