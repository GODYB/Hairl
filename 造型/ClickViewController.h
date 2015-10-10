//
//  ClickViewController.h
//  Hair
//
//  Created by 冰刀画的圈。 on 15/10/8.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClickTableViewCell.h"
@interface ClickViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong,nonatomic) NSString *nameitem;
@property (strong,nonatomic)NSArray * objectsForShow;
@end
