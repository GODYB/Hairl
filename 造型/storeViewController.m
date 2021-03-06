//
//  storeViewController.m
//  Hair
//
//  Created by ajw on 15/9/26.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import "storeViewController.h"
#import "goodsViewController.h"
@interface storeViewController ()
- (IBAction)return:(UIButton *)sender forEvent:(UIEvent *)event;



@end

@implementation storeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    [self requestData];
    
    [self uiConfiguration];
}
-(void)viewWillAppear:(BOOL)animated {
//单利化全局变量
if ([[[storageMgr singletonStorageMgr] objectForKey:@"background"] integerValue] == 0) {
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BJ-1"]];
} else {
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BJ-2"]];
    
}
    
    
[super viewWillAppear:animated];//视图出现之前做的事情
}


-(void)uiConfiguration
{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    NSString *title = [NSString stringWithFormat:@"下拉即可刷新"];
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentCenter];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    
    NSDictionary *attrsDictionary = @{NSUnderlineStyleAttributeName:
                                          @(NSUnderlineStyleNone),
                                      NSFontAttributeName:[UIFont preferredFontForTextStyle:UIFontTextStyleBody],
                                      NSParagraphStyleAttributeName:style,
                                      NSForegroundColorAttributeName:[UIColor brownColor]};
    
    
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
    refreshControl.attributedTitle = attributedTitle;
    //tintColor旋转的小花的颜色
    refreshControl.tintColor = [UIColor brownColor];
    //背景色 浅灰色
    refreshControl.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //执行的动作
    [refreshControl addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:refreshControl];
}

- (void)refreshData:(UIRefreshControl *)rc
{
    [_tableView reloadData];
    //怎么样让方法延迟执行的
    [self performSelector:@selector(endRefreshing:) withObject:rc afterDelay:0.4f];
}

//下拉刷新闭合
- (void)endRefreshing:(UIRefreshControl *)rc
{
    [rc endRefreshing];//闭合
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)requestData {
   
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"owner == %@", currentUser];//筛选字段
    
    PFQuery *query = [PFQuery queryWithClassName:@"business"];//查询的是那张表
    //predicate:predicate
    

    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray *returnedObjects, NSError *error) {
        [aiv stopAnimating];
        if (!error) {
            _objectsForShow = returnedObjects;
            NSLog(@"%@", _objectsForShow);
            [_tableView reloadData];
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PFObject *object = [_objectsForShow objectAtIndex:indexPath.row];
    goodsViewController *pvc = [Utilities getStoryboardInstanceByIdentity:@"Add"];
    //    PFObject *par = object[@"owner"];
    //    pvc.ownername = par;
    pvc.item = object;
//    pvc.kro =object;
    pvc.hidesBottomBarWhenPushed = YES;//把切换按钮隐藏掉
    [self.navigationController pushViewController:pvc animated:YES];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _objectsForShow.count;  //添加行 行不对 数据就不对
  
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableSampleIdentifier = @"cell";
    
    AllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                              TableSampleIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[AllTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:TableSampleIdentifier];
    }
    
    PFObject *object = [_objectsForShow objectAtIndex:indexPath.row];
    [object[@"businessPhoto"] getDataInBackgroundWithBlock:^(NSData *photoData, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:photoData];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (image) {
                    cell.photo.image = image;
                } else {
                    NSLog(@"IN");
                    cell.photo.image = nil;
                }
            });
        }
    }];
    if ([[[storageMgr singletonStorageMgr] objectForKey:@"background"] integerValue] == 0) {
        cell.Newtime.image=[UIImage imageNamed:@"TB-6"];
        cell.Newaddress.image=[UIImage imageNamed:@"TB-7"];
    } else {
        cell.Newtime.image=[UIImage imageNamed:@"TB-1"];
        cell.Newaddress.image=[UIImage imageNamed:@"TB-2"];
    }
    
    cell.name.text = [NSString stringWithFormat:@"%@",object[@"businessName"]];
    cell.time.text = [NSString stringWithFormat:@"%@",object[@"businesshours"]];
      cell.address.text = [NSString stringWithFormat:@"%@",object[@"address"]];
   
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
    
}







- (IBAction)return:(UIButton *)sender forEvent:(UIEvent *)event {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
