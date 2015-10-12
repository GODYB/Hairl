//
//  mineViewController.h
//  Hair
//
//  Created by 冰刀画的圈。 on 15/10/10.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mineViewController : UIViewController<UITableViewDataSource,UITableViewDelegate, UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

{
    BOOL idedit;
}
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *ulable1;
@property (weak, nonatomic) IBOutlet UIButton *savebutton;
@property (weak, nonatomic) IBOutlet UIButton *editbutton;
@property(strong,nonatomic)NSArray *objectviewshow;
@property(strong,nonatomic)NSMutableArray *objectArray;
@property(strong,nonatomic)NSArray *objects;
//调用

@property (strong, nonatomic) UIImagePickerController *imagePickerController;

@property (strong,nonatomic)NSString *sesting1;
@property (strong,nonatomic)NSString *sisting2;
@property (strong,nonatomic)NSString *xisting3;
@property (strong,nonatomic)NSString *addsting4;
@property (strong,nonatomic)NSString *sesting5;
@property (strong,nonatomic)NSString *sesting6;
@property (strong,nonatomic)NSString *sesting7;
@end
