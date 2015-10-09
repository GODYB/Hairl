//
//  TabViewController.m
//  Hair
//
//  Created by ajw on 15/9/25.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import "TabViewController.h"

@interface TabViewController ()

@end

@implementation TabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    if([userDefaults objectForKey:@"FirstLoad"] == nil) {
        [userDefaults setBool:NO forKey:@"FirstLoad"];
        //显示引导页
        [self showIntroWithCrossDissolve ];
    }

}
- (void)showIntroWithCrossDissolve {
    //给每个引导页加载图片
    EAIntroPage *page1 = [EAIntroPage page];
    page1.bgImage = [UIImage imageNamed:@"HP-1"];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.bgImage = [UIImage imageNamed:@"HP-4"];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.bgImage = [UIImage imageNamed:@"HP-2"];
    
    EAIntroPage *page4 = [EAIntroPage page];
    page4.bgImage = [UIImage imageNamed:@"HP-3"];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3,page4]];
    
    [intro setDelegate:self];
    [intro showInView:self.view animateDuration:0.1];
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

////选择的图片
//UITabBar *tabBar = self.tabBar;
//UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
//UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
//UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
//tabBarItem1.title = @"title1";
//tabBarItem2.title = @"title2";
//UIImage* selectedImage = [UIImage imageNamed:@"xxxx.png"];
//
////声明这张图片用原图(别渲染)
//selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//[tabBarItem1 setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:[UIImage imageNamed:@"xxx.png"]];
//[tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"xxxx.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"xxxx.png"]];

@end
