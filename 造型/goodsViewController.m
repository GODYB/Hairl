//
//  goodsViewController.m
//  Hair
//
//  Created by ajw on 15/9/29.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import "goodsViewController.h"
#import  "uploadViewController.h"
@interface goodsViewController ()
{
     BOOL _isButtion;
}

- (IBAction)Focus:(UIButton *)sender forEvent:(UIEvent *)event;

@end

@implementation goodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    _tableViewtwo.hidden=YES;
    [self requestData];
    [self focusData];
    PFFile *photo = _item[@"businessPhoto"];
    [photo getDataInBackgroundWithBlock:^(NSData *photoData, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:photoData];
            dispatch_async(dispatch_get_main_queue(), ^{
                _photo.image = image;
            });
        }
    }];
      _name.text =_item[@"businessName"];
    _time.text=_item[@"businesshours"];
    _professional.text=_item[@"address"];
 
 
//  @[@" 剪发", @"烫发", @"美发"];
    
    
}

-(void)viewWillAppear:(BOOL)animated {
   // 单利化全局变量
   
    if ([[[storageMgr singletonStorageMgr] objectForKey:@"background"] integerValue] == 0) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BJ-1"]];
    } else {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BJ-2"]];
        
    }
    [super viewWillAppear:animated];//视图出现之前做的事情
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
//{
//    return 2;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _objectsForShow.count;
   
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
             [_tableViewone reloadData];
         }
         else
         {
             NSLog(@"Error: %@ %@", error, [error userInfo]);
         }
     }];
}






- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFObject *object = [_objectsForShow objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", object[@"productName"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PFObject *object = [_objectsForShow objectAtIndex:indexPath.row];
    uploadViewController *pvc = [Utilities getStoryboardInstanceByIdentity:@"ADB"];
    //    PFObject *par = object[@"owner"];
    //    pvc.ownername = par;
    pvc.like = object;
    pvc.hidesBottomBarWhenPushed = YES;//把切换按钮隐藏掉
    [self.navigationController pushViewController:pvc animated:YES];

    
//      12:08:26
//    - (IBAction)send:(UIBarButtonItem *)sender {
//        
//        SendpostViewController *denglu = [self.storyboard instantiateViewControllerWithIdentifier:@"send"];
//        denglu.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:denglu animated:YES];
//    }
    
}


//NSPredicate *predicate = [NSPredicate predicateWithFormat:
//                          @"hairdname= '王美丽"];
//PFQuery *query = [PFQuery queryWithClassName:@"hairdresser" predicate:predicate];

//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//
//  
//}


- (IBAction)Focus:(UIButton *)sender forEvent:(UIEvent *)event {
    PFUser *user = [PFUser currentUser];
    if(!user){
        [self showAlert];
        
    }else
    {
        
        if(_isButtion == YES){
            _isButtion = NO;
            [_collection setBackgroundImage:[UIImage imageNamed:@"AN-8"] forState:UIControlStateNormal];
            
            [self quxiaoData];
            
            
        }else if(_isButtion == NO) {
            _isButtion = YES;
            [_collection setBackgroundImage:[UIImage imageNamed:@"AN-7"] forState:UIControlStateNormal];
            PFObject *praise = [PFObject objectWithClassName:@"collection"];
            praise[@"youUser"] = _item;
            praise[@"meUser"] = user;
            praise[@"shoucang"]=@"收藏";
            
            [praise saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
                if (succeeded){
                    NSLog(@"Object Uploaded!");
                    [self focusData];
                }
                else{
                    NSLog(@"error=%@",error);
                }
                
            }];
            NSLog(@" 收藏==  %@",praise[@"shoucang"]);
            
            
        }
    }
}

-(void)focusData
{
    PFUser *current=[PFUser currentUser];
    
    NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@" youUser == %@ AND meUser == %@",_item, current];
    PFQuery *query3 = [PFQuery queryWithClassName:@"collection" predicate:predicate3];
    NSLog(@" query3  == %@ ",query3);
    
    [query3 countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        if (!error) {
            if (number == 0) {
                _isButtion = NO;
                [_collection setBackgroundImage:[UIImage imageNamed:@"AN-8"] forState:UIControlStateNormal];
            } else {
                _isButtion = YES;
                [_collection setBackgroundImage:[UIImage imageNamed:@"AN-7"] forState:UIControlStateNormal];
            }
        }
        else{
            NSLog(@"error=%@",error);
        }
        
    }];
}

-(void)quxiaoData
{
    PFUser *current=[PFUser currentUser];
    
    NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@" youUser == %@ AND meUser == %@",_item, current];
    PFQuery *query3 = [PFQuery queryWithClassName:@"collection" predicate:predicate3];
    NSLog(@" query3  == %@ ",query3);
    
    [query3 countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        if (!error) {
            if (!number == 0) {
                PFUser *current=[PFUser currentUser];
                
                NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@" youUser == %@ AND meUser == %@",_item, current];
                
                
                PFQuery *query4 = [PFQuery queryWithClassName:@"collection" predicate:predicate3];
                
                [query4 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                    if (!error) {
                        for (PFObject *quxiao in objects) {
                            [quxiao deleteInBackground];
                        }
                    }
                }];
                
                
                
                
                
            }
        }
        else{
            NSLog(@"error=%@",error);
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
