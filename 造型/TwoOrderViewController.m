//
//  TwoOrderViewController.m
//  Hair
//
//  Created by 冰刀画的圈。 on 15/10/12.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import "TwoOrderViewController.h"

@interface TwoOrderViewController ()

@end

@implementation TwoOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"X-bj"]];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式
    NSString *dateString = [dateFormat stringFromDate:_orderitem[@"orderDate"]]; //求出当天的时间字符串，当更改时间格式时，时间字符串也能随之改变
    _ordername.text = [NSString stringWithFormat:@"%@",_orderitem[@"orderName"]];
    _orderPice.text = [NSString stringWithFormat:@"%@",_orderitem[@"orderPrice"]];
    _shuoming.text = [NSString stringWithFormat:@"%@",_orderitem[@"orderState"]];
    _ordertime.text = [NSString stringWithFormat:@"%@",dateString];
    
    

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

@end
