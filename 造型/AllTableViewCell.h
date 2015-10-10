//
//  AllTableViewCell.h
//  Hair
//
//  Created by ajw on 15/9/29.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIImageView *Newtime;

@property (weak, nonatomic) IBOutlet UIImageView *Newaddress;

@end
