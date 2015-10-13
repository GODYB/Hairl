//
//  NeworderController.m
//  Hair
//
//  Created by ajw on 15/10/13.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import "NeworderController.h"

@interface NeworderController ()
- (IBAction)Newitem:(UIDatePicker *)sender forEvent:(UIEvent *)event;
- (IBAction)Porder:(UIButton *)sender forEvent:(UIEvent *)event;

@end

@implementation NeworderController

- (void)viewDidLoad {
    [super viewDidLoad];
    _name.text =_like[@"productName"];
    _timeLi.text =_like[@"producttime"];
    _price.text =_like[@"productPrice"];
    _LikeTime.minimumDate = [NSDate date];
    // Do any additional setup after loading the view.
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

- (IBAction)Newitem:(UIDatePicker *)sender forEvent:(UIEvent *)event {
    //date picker 把数据加进TextField里
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm a"];
    //创建字符串
    NSString *astring = [[NSString alloc] init];
    //stringFromDate返回值为字符
    astring = [dateFormatter stringFromDate:sender.date];
    _metime.text=astring;
}

- (IBAction)Porder:(UIButton *)sender forEvent:(UIEvent *)event {
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



@end
