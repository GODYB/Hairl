//
//  goodOrderController.h
//  Hair
//
//  Created by ajw on 15/10/10.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface goodOrderController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *Storephoto;
@property (weak, nonatomic) IBOutlet UIImageView *package;
@property (weak, nonatomic) IBOutlet UIImageView *money;
@property (weak, nonatomic) IBOutlet UIImageView *store;
@property (weak, nonatomic) IBOutlet UILabel *Newpackage;
@property (weak, nonatomic) IBOutlet UILabel *Newmoney;
@property (weak, nonatomic) IBOutlet UILabel *Newstore;
@property (weak, nonatomic) IBOutlet UITextField *meitem;

@property (strong, nonatomic) PFObject *like;
@property(strong,nonatomic)NSArray*objectsForShow;

@end
