//
//  goodsViewController.h
//  Hair
//
//  Created by ajw on 15/9/29.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface goodsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableViewone;

@property(strong,nonatomic)NSArray*objectsForShow;


@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *professional;


@property (strong, nonatomic) PFObject *item;
@property (weak, nonatomic) IBOutlet UIButton *collection;
@property (weak, nonatomic) IBOutlet UIImageView *TBone;
@property (weak, nonatomic) IBOutlet UIImageView *TBtwo;



@end
