//
//  TwoOrderViewController.h
//  Hair
//
//  Created by 冰刀画的圈。 on 15/10/12.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwoOrderViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *ordertime;
@property (weak, nonatomic) IBOutlet UILabel *ordername;
@property (weak, nonatomic) IBOutlet UILabel *orderPice;
@property (weak, nonatomic) IBOutlet UILabel *shuoming;

@property (strong, nonatomic) PFObject *orderitem;
@end
