//
//  rewardViewController.m
//  Hair
//
//  Created by 冰刀画的圈。 on 15/9/26.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import "rewardViewController.h"
#import "HomeViewController.h"
@interface rewardViewController ()


- (IBAction)queding:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)change:(UITapGestureRecognizer *)sender;

- (IBAction)xjc:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)tf:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)ddzs:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)fanghui:(UIBarButtonItem *)sender;
- (IBAction)rf:(UIButton *)sender forEvent:(UIEvent *)event;
@end
@implementation rewardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _selection = [NSMutableArray new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    [theTextField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
- (void)showOrderText {
    NSString *sum = @"";
    for (NSString *str in _selection) {
        sum = [NSString stringWithFormat:@"%@;%@", sum, str];
    }
    if ([sum isEqualToString:@""]) {
        _orderText.text = @"";
    } else {
        _orderText.text = [sum substringFromIndex:1];
    }
}

- (IBAction)xjc:(UIButton *)sender forEvent:(UIEvent *)event
{
    desi1 = @"洗剪吹";
    if ([_selection containsObject:desi1]) {
        [_xjc setBackgroundColor:[UIColor clearColor]];
        [_selection removeObject:desi1];
    } else {
        [_xjc setBackgroundColor:[UIColor redColor]];
        [_selection addObject:desi1];
    }
    [self showOrderText];
}

- (IBAction)tf:(UIButton *)sender forEvent:(UIEvent *)event
{
    desi2 = @"烫发";
    if ([_selection containsObject:desi2]) {
        [_tf setBackgroundColor:[UIColor clearColor]];
        [_selection removeObject:desi2];
    } else {
        [_tf setBackgroundColor:[UIColor redColor]];
        [_selection addObject:desi2];
    }
    [self showOrderText];
}

- (IBAction)ddzs:(UIButton *)sender forEvent:(UIEvent *)event
{  
    desi3 = @"到店再说";
    if ([_selection containsObject:desi3]) {
        [_ddzs setBackgroundColor:[UIColor clearColor]];
        [_selection removeObject:desi3];
    } else {
        [_ddzs setBackgroundColor:[UIColor redColor]];
        [_selection addObject:desi3];
    }
    [self showOrderText];
}

- (IBAction)rf:(UIButton *)sender forEvent:(UIEvent *)event
{
    desi4 = @"染发";
    if ([_selection containsObject:desi4]) {
        [_rf setBackgroundColor:[UIColor clearColor]];
        [_selection removeObject:desi4];
    } else {
        [_rf setBackgroundColor:[UIColor redColor]];
        [_selection addObject:desi4];
    }
    [self showOrderText];

}
- (IBAction)queding:(UIButton *)sender forEvent:(UIEvent *)event
{
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        NSString *price = _orderPrice.text;
        NSString *demad =_orderText.text;
        NSString *title = _orderName.text;
        
        
        //NSString 转 NSNumber 格式
        NSNumberFormatter *numprice = [[NSNumberFormatter alloc] init];
        [numprice setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber *numTemp = [numprice numberFromString:price];
        
        
        NSNumber *a = [NSNumber numberWithInt:30];
        if ([price isEqualToString:@""] || [demad isEqualToString:@""] ||[title isEqualToString:@""]) {
            [Utilities popUpAlertViewWithMsg:@"请填写所有信息" andTitle:nil];
            return;
        }
        if (numTemp < a) {
            [Utilities popUpAlertViewWithMsg:@"悬赏金额不能低于30元" andTitle:nil];
            return;
        }
        PFObject *order = [PFObject objectWithClassName:@"Order"];
        order[@"orderPrice"] = numTemp;
        order[@"orderText"] = demad;
        order[@"orderName"] = title;
       NSData *photoData = UIImagePNGRepresentation(_touxian.image);
       PFFile *photoFile = [PFFile fileWithName:@"photo.png" data:photoData];
       order[@"uploadPictures"] = photoFile;
        NSLog(@"-------%@,%@,%@,--------",numTemp,demad,title);
        
        order[@"ouserId"] = currentUser;
        
        UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
        [order saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
            [aiv stopAnimating];
            if (succeeded) {
                [self.navigationController popViewControllerAnimated:YES];
                //[Utilities popUpAlertViewWithMsg:@"发布成功" andTitle:nil];
                UIAlertView *confirmView = [[UIAlertView alloc]initWithTitle:@"发布成功" message:@"是否停留到本页面"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [confirmView show];

            }else
            {
                [Utilities popUpAlertViewWithMsg:nil andTitle:nil];
                
            }
        }];
    } else
    {
        [self showAlert];
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        // 获取指定的Storyboard，name填写Storyboard的文件名
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        // 从Storyboard上按照identifier获取指定的界面（VC），identifier必须是唯一的
       HomeViewController *receive = [storyboard instantiateViewControllerWithIdentifier:@"IdReceive"];
        [self.navigationController pushViewController:receive animated:YES];
    }else
    {
        NSLog(@"看看别的，在下一档");
    }
}
- (IBAction)change:(UITapGestureRecognizer *)sender
{  
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
    [actionSheet setExclusiveTouch:YES];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 2)
        return;
    
    UIImagePickerControllerSourceType temp;
    if (buttonIndex == 0) {
        temp = UIImagePickerControllerSourceTypeCamera;
    } else if (buttonIndex == 1) {
        temp = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    if ([UIImagePickerController isSourceTypeAvailable:temp]) {
        _imagePickerController = nil;
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.allowsEditing = YES;
        _imagePickerController.sourceType = temp;
        [self presentViewController:_imagePickerController animated:YES completion:nil];
    } else {
        if (temp == UIImagePickerControllerSourceTypeCamera) {
            [Utilities popUpAlertViewWithMsg:@"当前设备无照相功能" andTitle:nil];
        }
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    _touxian.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)timerFireMethod:(NSTimer*)theTimer//弹出框
{
    UIAlertView *Alert = (UIAlertView*)[theTimer userInfo];
    [Alert dismissWithClickedButtonIndex:0 animated:NO];
      Alert =NULL;
}
- (void)showAlert{//时间
    UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请登录账号或注册账号"  delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(timerFireMethod:) userInfo:Alert repeats:YES];
    [Alert show];
}
- (IBAction)fanghui:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];

}

@end
