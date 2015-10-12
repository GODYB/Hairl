//
//  lineOrderTableViewCell.h
//  Hair
//
//  Created by 冰刀画的圈。 on 15/10/10.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lineOrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *ordername;
@property (weak, nonatomic) IBOutlet UILabel *orderpeice;
@property (weak, nonatomic) IBOutlet UILabel *zhutai;

@end
