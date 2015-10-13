//
//  collectionViewCell.h
//  Hair
//
//  Created by ajw on 15/10/13.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface collectionViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *Newname;

@property (weak, nonatomic) IBOutlet UIImageView *Newphoto;
@property (weak, nonatomic) IBOutlet UILabel *Newtime;
@property (weak, nonatomic) IBOutlet UILabel *Newaddress;

@end
