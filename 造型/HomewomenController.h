//
//  HomewomenController.h
//  Hair
//
//  Created by ajw on 15/9/25.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomewomenController : UIViewController
@property (weak, nonatomic) IBOutlet UINavigationItem *location;
@property (weak, nonatomic) IBOutlet UITableView *positioning;
@property(strong,nonatomic)NSArray*objectsForShow;
@property (strong, nonatomic)NSArray *shuzu;
@end
