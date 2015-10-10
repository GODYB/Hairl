//
//  ClickTableViewCell.h
//  Hair
//
//  Created by 冰刀画的圈。 on 15/10/9.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClickTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *storename;
@property (weak, nonatomic) IBOutlet UILabel *packname;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIImageView *imgge;
@property (weak, nonatomic) IBOutlet UIImageView *Oneicon;

@end
