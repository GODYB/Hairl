//
//  LeftViewController.h
//  Hair
//
//  Created by ajw on 15/9/25.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *tuichu;

@property (weak, nonatomic) IBOutlet UIImageView *Head;
@property (weak, nonatomic) IBOutlet UILabel *lable1;
@property (weak, nonatomic) IBOutlet UILabel *lable2;

@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@end
