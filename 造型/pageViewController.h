//
//  pageViewController.h
//  Hair
//
//  Created by ajw on 15/10/13.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *Newname;
@property (weak, nonatomic) IBOutlet UIImageView *Newphoto;
@property (strong, nonatomic) UIImageView *zoomIv;
@property (weak, nonatomic) IBOutlet UILabel *Newitme;
@property (weak, nonatomic) IBOutlet UILabel *Newaddress;
@property (weak, nonatomic) IBOutlet UITableView *Newtablew;

@property(strong,nonatomic)NSArray*objectsForShow;


@property (strong, nonatomic) PFObject *item;
@end
