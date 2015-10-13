//
//  collectionController.h
//  Hair
//
//  Created by ajw on 15/10/13.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "collectionViewCell.h"
@interface collectionController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *Newtable;
@property(strong,nonatomic)NSArray*objectsForShow;

@end
