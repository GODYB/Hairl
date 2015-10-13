//
//  MyRewardViewViewController.m
//  Hair
//
//  Created by 冰刀画的圈。 on 15/9/29.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import "MyRewardViewViewController.h"
#import "ABCIntroView/ABCIntroView.h"
@interface MyRewardViewViewController ()<ABCIntroViewDelegate>
- (IBAction)fanghui:(UIBarButtonItem *)sender;
@property ABCIntroView *introView;
@end

@implementation MyRewardViewViewController

- (void)viewDidLoad {
    /**
     *帮助滑动
     */
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"intro_screen_viewed"]) {
        self.introView = [[ABCIntroView alloc] initWithFrame:self.view.frame];
        self.introView.delegate = self;
//        self.introView.backgroundColor = [UIColor greenColor];
        [self.view addSubview:self.introView];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)onDoneButtonPressed
{
    
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.introView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.introView removeFromSuperview];
    }];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)fanghui:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
