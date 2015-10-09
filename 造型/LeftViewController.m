//
//  LeftViewController.m
//  Hair
//
//  Created by ajw on 15/9/25.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import "LeftViewController.h"

#import "Utilities.h"
#import "PrefixHeader.pch"

@interface LeftViewController ()
{
    id hidden;
    
}
- (IBAction)tuichu:(UIButton *)sender forEvent:(UIEvent *)event;



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
        _lable1.text = currentUser[@"realname"];
        _lable2.text=[NSString stringWithFormat:@"名称:   %@", currentUser[@"username"]];
        
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
        _lable1 = Nil;
        [self pange];
    }
}
-(void)pange
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    tapGesture.numberOfTapsRequired = 1; //点击次数
    tapGesture.numberOfTouchesRequired = 1; //点击手指数
    [self.view addGestureRecognizer:tapGesture];
    
}
//轻击手势触发方法
-(void)tapGesture:(UITapGestureRecognizer *)sender
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
            [self presentViewController:nc animated:YES completion:nil];
            //_hh.enabled = YES;
            //_buttonItem.enabled=YES;
        }
    }
}
- (IBAction)tuichu:(UIButton *)sender forEvent:(UIEvent *)event
{
    NSLog(@"sad");
    [PFUser logOut];
    [self read];
}
@end
