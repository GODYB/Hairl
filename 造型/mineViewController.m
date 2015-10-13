//
//  mineViewController.m
//  Hair
//
//  Created by 冰刀画的圈。 on 15/10/10.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import "mineViewController.h"
#import "mineTableViewCell.h"
@interface mineViewController ()

- (IBAction)chuping:(UITapGestureRecognizer *)sender;
- (IBAction)save:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)edit:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)fanghui:(UIBarButtonItem *)sender;

@end

@implementation mineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background3"]];
    //设置按钮为圆
    _image.layer.cornerRadius = _image.bounds.size.width/2;
    _image.layer.masksToBounds = YES;

//    CALayer *layer = [_savebutton layer];
//    layer.cornerRadius = 40;//角的弧度
//    layer.borderColor = [[UIColor redColor]CGColor];
//    layer.borderWidth = 1;//边框宽度
//    layer.masksToBounds = YES;//图片填充边框
    _objectviewshow=[[NSMutableArray alloc]initWithObjects:@"用户名",@"真实姓名",@"年龄",@"性别",@"邮箱",@"联系电话",@"代金券", nil];
    idedit = NO;
    _savebutton.hidden = YES;
    [self requestData];
    [self creatbutton];
    //_headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tupian1.jpg"]];
}
//点击return键盘回收
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}
//点击空白处键盘回收
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//获取数据

- (void)requestData {
    PFUser *currentUser = [PFUser currentUser];
    if (!(currentUser[@"username"])) {
        _ulable1.text=@"";
    }else
    {
        _ulable1.text = [NSString stringWithFormat:@"账号信息：%@", currentUser[@"username"]];
    }
    PFFile *photo = currentUser[@"photo"];
    [photo getDataInBackgroundWithBlock:^(NSData *photoData, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:photoData];
            dispatch_async(dispatch_get_main_queue(), ^{
                _image.image = image;
                [_tableview reloadData];
            });
        }
    }];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_objectviewshow count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    mineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.ulable3.text =[_objectviewshow objectAtIndex:indexPath.row];
    
    PFUser *user = [PFUser currentUser];
    
    cell.edit = idedit;
    
    
    if (indexPath.row==0)
    {
        if (!(user[@"username"]))
        {
            cell.text1.text=@"";
        }else
        {
            cell.text1.text=[NSString stringWithFormat:@"%@", user[@"username"]];
        }
        
    }else if (indexPath.row==1)
    {
        if (!(user[@"realname"]))
        {
            cell.text1.text=@"";
        }else
        {
            
            cell.text1.text=[NSString stringWithFormat:@"%@", user[@"realname"]];
        }
    }
    else if (indexPath.row==2)
    {
        if (!(user[@"age"]))
        {
            cell.text1.text=@"";
        }else
        {
            
            cell.text1.text=[NSString stringWithFormat:@"%@", user[@"age"]];
        }
    }
    else if (indexPath.row==3)
    {
        if (!(user[@"sex"]))
        {
             cell.text1.text=@"";
        }else
        {
            cell.text1.text=[NSString stringWithFormat:@"%@", user[@"sex"]];
        }
    }
    else if (indexPath.row==4)
    {
        if (!(user[@"email"]))
        {
            cell.text1.text=@"";
        }else
        {
            cell.text1.text=[NSString stringWithFormat:@"%@", user[@"email"]];
        }
    }
    else if (indexPath.row==5)
    {
        if (!(user[@"PhoneCode"]))
        {
            cell.text1.text=@"";
        }else
        {
            cell.text1.text=[NSString stringWithFormat:@"%@", user[@"PhoneCode"]];
        }
    }
    else if (indexPath.row==6)
    {
        if (!(user[@"voucher"]))
        {
            cell.text1.text=@"";
        }else
        {
            cell.text1.text=[NSString stringWithFormat:@"%@", user[@"voucher"]];
        }
    }

    
    if (idedit == YES) {
        if (indexPath.row==0) {
            if (!(cell.text1.text)) {
                _sesting1 = @"";
            }
            _sesting1 = cell.text1.text;
        }else if (indexPath.row==1)
        {
            if (!(cell.text1.text)) {
                _sisting2 = @"";
            }
            _sisting2 = cell.text1.text;
        }
        else if (indexPath.row==2)
        {
            if (!(cell.text1.text)) {
                _xisting3 = @"";
            }
            _xisting3 = cell.text1.text;
        }
        else if (indexPath.row==3)
        {
            if (!(cell.text1.text)) {
                _addsting4 = @"";
            }
            _addsting4 = cell.text1.text;
        }
        else if (indexPath.row==4)
        {
            if (!(cell.text1.text)) {
                _sesting5 = @"";
            }
            _sesting5 = cell.text1.text;
        }
        else if (indexPath.row==5)
        {
            if (!(cell.text1.text)) {
                _sesting6 = @"";
            }
            _sesting6 = cell.text1.text;
        }
        else if (indexPath.row==6)
        {
            if (!(cell.text1.text)) {
                _sesting7 = @"";
            }
            _sesting7 = cell.text1.text;
        }


    }
    NSLog(@"cell.text1.text = %@", cell.text1.text);
    
    return cell;
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
    _image.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
    //    上传图片
    PFUser *currentUser = [PFUser currentUser];
    NSData *photoData = UIImagePNGRepresentation(_image.image);
    PFFile *photoFile = [PFFile fileWithName:@"photo.png" data:photoData];
    currentUser[@"photo"] = photoFile;
    
    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    
    [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [aiv stopAnimating];
        if (succeeded) {
            [[NSNotificationCenter defaultCenter] performSelectorOnMainThread:@selector(postNotification:) withObject:[NSNotification notificationWithName:@"refreshMine" object:self] waitUntilDone:YES];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [Utilities popUpAlertViewWithMsg:nil andTitle:nil];
        }
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(void)creatbutton
{
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.translucent=NO;
    _editbutton.titleLabel.text=@"编辑";
    
}

- (IBAction)chuping:(UITapGestureRecognizer *)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
    [actionSheet setExclusiveTouch:YES];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
}

- (IBAction)save:(UIButton *)sender forEvent:(UIEvent *)event
{
    PFUser *user = [PFUser currentUser];
    
    mineTableViewCell *cell1 = (mineTableViewCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSLog(@"username = %@", cell1.text1.text);
    user[@"username"] = cell1.text1.text;
    
    mineTableViewCell *cell2 = (mineTableViewCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    NSLog(@"realname = %@", cell2.text1.text);
    user[@"realname"] = cell2.text1.text;
    
    mineTableViewCell *cell3 = (mineTableViewCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    NSLog(@"age = %@", cell3.text1.text);
    user[@"age"] = cell3.text1.text;
    
    mineTableViewCell *cell4 = (mineTableViewCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    NSLog(@"sex = %@", cell4.text1.text);
    user[@"sex"] = cell4.text1.text;
    
    mineTableViewCell *cell5 = (mineTableViewCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    NSLog(@"email = %@", cell5.text1.text);
    user[@"email"] = cell5.text1.text;
    
    mineTableViewCell *cell6 = (mineTableViewCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    NSLog(@"PhoneCode = %@", cell6.text1.text);
    user[@"PhoneCode"] = cell6.text1.text;

    
    mineTableViewCell *cell7 = (mineTableViewCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
    NSLog(@"voucher = %@", cell7.text1.text);
    user[@"voucher"] = cell7.text1.text;
    NSLog(@"user = %@", user);
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        if (succeeded) {
            [self requestData];
        } else {
            
        }
    }];
    idedit=NO;
    [_editbutton setTitle:@"编辑" forState:UIControlStateNormal];
    _savebutton.hidden = YES;


}
- (IBAction)edit:(UIButton *)sender forEvent:(UIEvent *)event
{
    if(idedit == NO)
    {
        
        idedit=YES;
        [_editbutton setTitle:@"取消" forState:UIControlStateNormal];
        _savebutton.hidden = NO;
        
        [_tableview reloadData];
    }
    else if([_editbutton.titleLabel.text isEqualToString:@"取消"])
    {
        idedit=NO;
        [_editbutton setTitle:@"编辑" forState:UIControlStateNormal];
        _savebutton.hidden = YES;
        
        [_tableview reloadData];
    }


}

- (IBAction)fanghui:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
