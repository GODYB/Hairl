//
//  goodOrderController.m
//  Hair
//
//  Created by ajw on 15/10/10.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import "goodOrderController.h"

@interface goodOrderController ()
- (IBAction)upload:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)Liketime:(UIDatePicker *)sender forEvent:(UIEvent *)event;

@end

@implementation goodOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
  _Newpackage.text =_like[@"productName"];
    _Newmoney.text=_like[@"productPrice"];
      _Likedata.minimumDate = [NSDate date];
    [self requestData];
}

-(void)viewWillAppear:(BOOL)animated {
    //单利化全局变量
    if ([[[storageMgr singletonStorageMgr] objectForKey:@"background"] integerValue] == 0) {
       _money.image=[UIImage imageNamed:@"TB-4"];
       _store.image=[UIImage imageNamed:@"TB-10"];
           self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BJ-1"]];
    } else {
        _money.image=[UIImage imageNamed:@"TB-5"];
        _store.image=[UIImage imageNamed:@"TB-8"];
           self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BJ-2"]];
        
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

//-
//[query includeKey:@"pbusinessId"];

/**
 *上传
 */

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
      
        
        [self requestDataell];
    }
}
- (void)requestData {

    //关联后由A查找B
    PFObject *Buser = _like[@"pbusinessId"];
    _Newstore.text=Buser[@"businessName"];

 
    PFFile *photo = Buser[@"businessPhoto"];
    [photo getDataInBackgroundWithBlock:^(NSData *photoData, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:photoData];
            dispatch_async(dispatch_get_main_queue(), ^{
                _Storephoto.image = image;
            });
        }
    }];
    
   
    


}


- (void)requestDataell
{
   
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
//    PFObject *Buser = _like[@"pbusinessId"];
     
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm a"];
    
    NSString *Duration = self.meitem.text;
    NSDate* inputDate  = [dateFormatter dateFromString:Duration];
    NSString *astring = _like[@"productPrice"];
    NSLog(@"%@",astring);
    NSNumberFormatter *numprice = [[NSNumberFormatter alloc] init];
    [numprice setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *numTemp = [numprice numberFromString:astring];
    NSLog(@"%@",numTemp);
    PFObject *Book = [PFObject objectWithClassName:@"Order"];
    Book[@"orderDate"] = inputDate;
    Book[@"orderPrice"] = numTemp;
    Book[@"orderName"] =_like[@"productName"];
    
    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    PFUser *currentUser = [PFUser currentUser];//获取当前用户的实例,创建关联
    Book[@"ouserId"] = currentUser;
//    Book[@"obusiness"]=_like;
    [Book saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
     {
         [aiv stopAnimating];//停止转动
         if (succeeded) {
             
             [self dismissViewControllerAnimated:YES completion:nil];
             //返回首页 返回上一页
             //[self.navigationController popViewControllerAnimated:YES];//返回上个页面
             UIAlertView *confirmView = [[UIAlertView alloc]initWithTitle:@"是否确认您的订单" message:@"并返回主页" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
             [confirmView show];
            
         } else {
             NSLog(@"%@", [error description]);
             [Utilities popUpAlertViewWithMsg:nil andTitle:nil];
         }
         
     }];
   
    } else
    {
        [self showAlert];
    }
}

- (void)timerFireMethod:(NSTimer*)theTimer//弹出框
{
    UIAlertView *Alert = (UIAlertView*)[theTimer userInfo];
    [Alert dismissWithClickedButtonIndex:0 animated:NO];
    Alert =NULL;
}
- (void)showAlert{//时间
    UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请登录账号或注册账号"  delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(timerFireMethod:) userInfo:Alert repeats:YES];
    [Alert show];
}

- (IBAction)upload:(UIButton *)sender forEvent:(UIEvent *)event {
    NSString *Duration = self.meitem.text;
    
    if ([ Duration  isEqualToString:@""])
    {
        [Utilities popUpAlertViewWithMsg:@"请选择时间" andTitle:nil];
        return;
        
    }
    [self requestDataell];
 
}



- (IBAction)Liketime:(UIDatePicker *)sender forEvent:(UIEvent *)event {
    //date picker 把数据加进TextField里
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm a"];
    //创建字符串
    NSString *astring = [[NSString alloc] init];
    //stringFromDate返回值为字符
    astring = [dateFormatter stringFromDate:sender.date];
    _meitem.text=astring;
    
}
@end
