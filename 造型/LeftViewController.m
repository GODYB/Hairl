//
//  LeftViewController.m
//  Hair
//
//  Created by ajw on 15/9/25.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import "LeftViewController.h"
#import "rderViewController.h"
#import "Utilities.h"
#import "PrefixHeader.pch"

@interface LeftViewController ()
{
    id hidden;
    
}
- (IBAction)tuichu:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)chuping:(UITapGestureRecognizer *)sender;
- (IBAction)dingdan:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)shezhi:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)collection:(UIButton *)sender forEvent:(UIEvent *)event;



@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置按钮为圆
    _Head.layer.cornerRadius =_Head.bounds.size.width/2;
    _Head.layer.masksToBounds = YES;

 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    //单利化全局变量
    if ([[[storageMgr singletonStorageMgr] objectForKey:@"rukou"] integerValue] == 0) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"man"]];
    } else {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"woman"]];
    }
    [super viewWillAppear:animated];//视图出现之前做的事情
    [self read];

}

-(void)read
{
    PFUser *currentUser = [PFUser currentUser];
    NSLog(@"%@", currentUser);
    if (currentUser) {
        NSLog(@"Y");
       // _lable1.text = currentUser[@"realname"];
        _lable1.text= Nil;
        _lable2.text=[NSString stringWithFormat:@"昵称:   %@", currentUser[@"username"]];
        _tuichu.hidden = NO;
        PFFile *photo = currentUser[@"photo"];
        [photo getDataInBackgroundWithBlock:^(NSData *photoData, NSError *error) {
            if (!error) {
                UIImage *image = [UIImage imageWithData:photoData];
                dispatch_async(dispatch_get_main_queue(), ^{
                    _Head.image = image;
                    
                });
            }
        }];
    }else{
         _Head.image = Nil;
        _lable2.text= Nil;
        _tuichu.hidden = YES;
    }
}
- (IBAction)tuichu:(UIButton *)sender forEvent:(UIEvent *)event
{
    NSLog(@"sad");
    [PFUser logOut];
    [self read];
    _lable1.text = @"请先登录";
}

- (IBAction)chuping:(UITapGestureRecognizer *)sender
{
    
    NSLog(@"sadasdasd");
    PFUser *user = [PFUser currentUser];
    if (!user) {
        LeftViewController *denglu = [self.storyboard instantiateViewControllerWithIdentifier:@"denglu"];
        if (!hidden) {
            //初始化导航控制器
            UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:denglu];
            //动画效果
            nc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            //导航条隐藏掉
            nc.navigationBarHidden = NO;
            //类似那个箭头 跳转到第二个界面
            //[self presentViewController:nc animated:YES completion:nil];
            [self presentViewController:nc animated:YES completion:nil];
            _lable1.enabled = YES;
        }
    }

}

- (IBAction)dingdan:(UIButton *)sender forEvent:(UIEvent *)event
{
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
    NSLog(@"dddddddddddddddddddddddddd");
    LeftViewController *dingdan = [self.storyboard instantiateViewControllerWithIdentifier:@"Iddd"];
    if (!hidden) {
        //初始化导航控制器
        UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:dingdan];
        //动画效果
        nc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        //导航条隐藏掉
        nc.navigationBarHidden = NO;
        //类似那个箭头 跳转到第二个界面
        //[self presentViewController:nc animated:YES completion:nil];
        [self presentViewController:nc animated:YES completion:nil];
  }
    }
    else
    {
        [self showAlert];
    }

}

- (IBAction)shezhi:(UIButton *)sender forEvent:(UIEvent *)event
{
   
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        NSLog(@"hhhhhhhhhhhhhhhhhhhhh");
        LeftViewController *shezhi = [self.storyboard instantiateViewControllerWithIdentifier:@"Ihhh"];
        if (!hidden) {
            //初始化导航控制器
            UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:shezhi];
            //动画效果
            nc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            //导航条隐藏掉
            nc.navigationBarHidden = NO;
            //类似那个箭头 跳转到第二个界面
            //[self presentViewController:nc animated:YES completion:nil];
            [self presentViewController:nc animated:YES completion:nil];
        }
    }
    else
    {
        [self showAlert];
    }
}

- (IBAction)collection:(UIButton *)sender forEvent:(UIEvent *)event {
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
    LeftViewController*dingdan = [self.storyboard instantiateViewControllerWithIdentifier:@"Lib"];
    //初始化导航控制器
    UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:dingdan];
    //动画效果
    nc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    //导航条隐藏掉
    nc.navigationBarHidden = NO;
    //类似那个箭头 跳转到第二个界面
    //[self presentViewController:nc animated:YES completion:nil];
    UIButton *_Newreturn = [UIButton buttonWithType:UIButtonTypeCustom];
    _Newreturn.frame = CGRectMake(0, 0, 44, 44);
    [_Newreturn setImage:[UIImage imageNamed:@"AN-1"] forState:UIControlStateNormal];
    [_Newreturn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    //_Newreturn.backgroundColor = [UIColor redColor];
    UIBarButtonItem *favoBarButton = [[UIBarButtonItem alloc] initWithCustomView:_Newreturn];
    //  favoBarButton:[UIImage imaeNamed:@"AN-7"];
    //           [self.favoBarButton setImage:[UIImage imageNamed:@"AN-7"] forState:UIControlStateNormal];
    dingdan.navigationItem.leftBarButtonItem = favoBarButton;
    
    [self presentViewController:nc animated:YES completion:nil];
    }else
    {
        [self showAlert];
    }
    
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
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

@end
