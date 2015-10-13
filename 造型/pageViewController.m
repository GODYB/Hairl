//
//  pageViewController.m
//  Hair
//
//  Created by ajw on 15/10/13.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import "pageViewController.h"
#import "NeworderController.h"
@interface pageViewController ()
{
    BOOL _isButtion;
}
- (IBAction)Newdelete:(UIBarButtonItem *)sender;


@end

@implementation pageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestData];

    [self queryimg];
     self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"X-bj"]];
}
-(void)queryimg
{
    NSLog(@"_item = %@", _item);
    PFObject *user = _item[@"youUser"];
    PFFile *photo = user[@"businessPhoto"];
    [photo getDataInBackgroundWithBlock:^(NSData *photoData, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:photoData];
            dispatch_async(dispatch_get_main_queue(), ^{
                _Newphoto.image = image;
            });
        }
    }];
    _Newname.text =user[@"businessName"];
    _Newitme.text =user[@"businesshours"];
    _Newaddress.text=user[@"address"];
}
- (UIImage *)imageUrl:(NSString *)url {
    if (nil == url || url.length == 0) {
        return nil;
    }
    static dispatch_queue_t backgroundQueue;
    if (backgroundQueue == nil) {
        backgroundQueue = dispatch_queue_create("com.beilyton.queue", NULL);
    }
    
    NSArray *directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [directories objectAtIndex:0];
    __block NSString *filePath = nil;
    filePath = [documentDirectory stringByAppendingPathComponent:[url lastPathComponent]];
    UIImage *imageInFile = [UIImage imageWithContentsOfFile:filePath];
    if (imageInFile) {
        return imageInFile;
    }
    
    __block NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    if (!data) {
        NSLog(@"Error retrieving %@", url);
        return nil;
    }
    UIImage *imageDownloaded = [[UIImage alloc] initWithData:data];
    dispatch_async(backgroundQueue, ^(void) {
        [data writeToFile:filePath atomically:YES];
        NSLog(@"Wrote to: %@", filePath);
    });
    return imageDownloaded;
}

- (void)photoTapAtIndexPath:(NSIndexPath *)indexPath {
   // PFObject *object = [_objectsForShow objectAtIndex:indexPath.row];
    _zoomIv = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _zoomIv.userInteractionEnabled = YES;
   // _zoomIv.image = [self imageUrl:object.imgUrl];
    _zoomIv.image=_Newphoto.image;
    _zoomIv.contentMode = UIViewContentModeScaleAspectFit;
    _zoomIv.backgroundColor = [UIColor blackColor];
    UITapGestureRecognizer *ivTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ivTap:)];
    [_zoomIv addGestureRecognizer:ivTap];
    [[[UIApplication sharedApplication] keyWindow] addSubview:_zoomIv];
}
- (void)ivTap:(UITapGestureRecognizer *)tap {
    if (tap.state == UIGestureRecognizerStateRecognized) {
        [_zoomIv removeFromSuperview];
        _zoomIv = nil;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)requestData {
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"product"];
    
    [query selectKeys:@[@"productName",@"producttime",@"productPrice"]];
    
    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray *returnedObjects, NSError *error)
     {
         [aiv stopAnimating];
         if (!error)
         {
             _objectsForShow = returnedObjects;
             NSLog(@"_objectsForShow = %@", _objectsForShow);
             [_Newtablew reloadData];
         }
         else
         {
             NSLog(@"Error: %@ %@", error, [error userInfo]);
         }
     }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    PFObject *object = [_objectsForShow objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", object[@"productName"]];
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _objectsForShow.count;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/








- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PFObject *object = [_objectsForShow objectAtIndex:indexPath.row];
   NeworderController *pvc = [Utilities getStoryboardInstanceByIdentity:@"AQW"];
    //    PFObject *par = object[@"owner"];
    //    pvc.ownername = par;
    pvc.like = object;
    pvc.hidesBottomBarWhenPushed = YES;//把切换按钮隐藏掉
    [self.navigationController pushViewController:pvc animated:YES];
    
    

    
}
- (IBAction)Newdelete:(UIBarButtonItem *)sender {
    PFUser *user =[PFUser currentUser];
    if(!user){
        [self showAlert];
        
    }
    [_item deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [Utilities popUpAlertViewWithMsg:@"取消收藏成功" andTitle:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
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

@end
