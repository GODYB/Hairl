//
//  NeworderController.h
//  Hair
//
//  Created by ajw on 15/10/13.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NeworderController : UIViewController
@property (strong, nonatomic) PFObject *like;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *timeLi;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UITextField *metime;
@property (weak, nonatomic) IBOutlet UIDatePicker *LikeTime;

@property(strong,nonatomic)NSArray*objectsForShow;
@end
