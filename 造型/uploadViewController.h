//
//  uploadViewController.h
//  Hair
//
//  Created by ajw on 15/10/8.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface uploadViewController : UIViewController 
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *timeLi;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UITextField *metime;
@property (weak, nonatomic) IBOutlet UIDatePicker *LikeTime;



@property (weak, nonatomic) IBOutlet UIButton *upload;
@property (strong, nonatomic) PFObject *like;

//NSString *astring = [[NSString alloc] init];

@property(strong,nonatomic)NSArray*objectsForShow;
@end
