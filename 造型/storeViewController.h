//
//  storeViewController.h
//  Hair
//
//  Created by ajw on 15/9/26.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  "AllTableViewCell.h"
@interface storeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;




@property (strong, nonatomic) NSArray *objectsForShow;

@end
