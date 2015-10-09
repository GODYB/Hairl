//
//  IntroView.m
//  DrawPad
//
//  Created by Adam Cooper on 2/4/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import "ABCIntroView.h"

@interface ABCIntroView () <UIScrollViewDelegate>
@property (strong, nonatomic)  UIScrollView *scrollView;
@property (strong, nonatomic)  UIPageControl *pageControl;
@property UIView *holeView;
@property UIView *circleView;
@property UIButton *doneButton;

@end

@implementation ABCIntroView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
//        UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.frame];
//        backgroundImageView.image = [UIImage imageNamed:@"Intro_Screen_Background"];
//        [self addSubview:backgroundImageView];
        
        
        
        
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        self.scrollView.pagingEnabled = YES;
        [self addSubview:self.scrollView];
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height*.8, self.frame.size.width, 10)];
        self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.153 green:0.533 blue:0.796 alpha:1.000];
        [self addSubview:self.pageControl];
        
        [self createViewOne];
        [self createViewTwo];
        [self createViewThree];
        [self createViewFour];
        
        
        
        self.pageControl.numberOfPages = 4;
        self.scrollView.contentSize = CGSizeMake(self.frame.size.width*4, self.scrollView.frame.size.height);
        
        //This is the starting point of the ScrollView
        CGPoint scrollPoint = CGPointMake(0, 0);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
    return self;
}

- (void)onFinishedIntroButtonPressed:(id)sender {
    [self.delegate onDoneButtonPressed];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
//    CGFloat pageWidth = CGRectGetWidth(self.bounds);
    CGFloat pageWidth = CGRectGetWidth(self.frame);
    CGFloat pageFraction = self.scrollView.contentOffset.x / pageWidth;
    self.pageControl.currentPage = roundf(pageFraction);
    
}


-(void)createViewOne{
    
    UIView *view = [[UIView alloc] initWithFrame:self.frame];
    
    
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.frame];
    
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    imageview.image = [UIImage imageNamed:@"xs1"];
    [view addSubview:imageview];
    
    
    
    self.scrollView.delegate = self;
    [self.scrollView addSubview:view];
    
}


-(void)createViewTwo{
    
    CGFloat originWidth = self.frame.size.width;
    CGFloat originHeight = self.frame.size.height;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(originWidth, 0, originWidth, originHeight)];
    
    
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.frame];
    
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    imageview.image = [UIImage imageNamed:@"xs2"];
    [view addSubview:imageview];
    
    
    self.scrollView.delegate = self;
    [self.scrollView addSubview:view];
    
}

-(void)createViewThree{
    
    CGFloat originWidth = self.frame.size.width;
    CGFloat originHeight = self.frame.size.height;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(originWidth*2, 0, originWidth, originHeight)];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.frame];
    
    
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    imageview.image = [UIImage imageNamed:@"xs2"];
    [view addSubview:imageview];
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    imageview.image = [UIImage imageNamed:@"xs3"];
    [view addSubview:imageview];
    
    
    
    self.scrollView.delegate = self;
    [self.scrollView addSubview:view];
    
}


-(void)createViewFour{
    
    CGFloat originWidth = self.frame.size.width;
    CGFloat originHeight = self.frame.size.height;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(originWidth*3, 0, originWidth, originHeight)];
    
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.frame];
    
    
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    imageview.image = [UIImage imageNamed:@"xs2"];
    [view addSubview:imageview];
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    imageview.image = [UIImage imageNamed:@"xs4"];
    [view addSubview:imageview];
    
    self.scrollView.delegate = self;
    [self.scrollView addSubview:view];
    
}

@end

// 发布代码于最专业的源码分享网站: Code4App.com