//
//  rewardViewController.h
//  Hair
//
//  Created by 冰刀画的圈。 on 15/9/26.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface rewardViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    id desi1,desi2,desi3,desi4;
}

@property (weak, nonatomic) IBOutlet UITextField *orderName;
@property (weak, nonatomic) IBOutlet UITextField *orderPrice;

@property (weak, nonatomic) IBOutlet UITextField *orderText;

@property (weak, nonatomic) IBOutlet UIButton *xjc;
@property (weak, nonatomic) IBOutlet UIButton *tf;
@property (weak, nonatomic) IBOutlet UIButton *ddzs;
@property (weak, nonatomic) IBOutlet UIButton *rf;
@property (strong, nonatomic) NSMutableArray *selection;
@property (weak, nonatomic) IBOutlet UIImageView *touxian;

@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@end
