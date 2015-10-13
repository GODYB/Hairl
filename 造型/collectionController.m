//
//  collectionController.m
//  Hair
//
//  Created by ajw on 15/10/13.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import "collectionController.h"
#import  "pageViewController.h"
@interface collectionController ()

@end

@implementation collectionController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self requestData];
    [self uiConfiguration];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];//视图出现之前做的事情
    [self requestData];
    
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
    
//    //背景色 浅灰色
//    refreshControl.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    //执行的动作
//    refreshControl.tag = 8001;
//    [refreshControl addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventValueChanged];
    [_Newtable addSubview:refreshControl];
//        [_Newtable reloadData];
}

- (void)refreshData:(UIRefreshControl *)rc
{
    [_Newtable reloadData];
    //怎么样让方法延迟执行的
    [self performSelector:@selector(endRefreshing:) withObject:rc afterDelay:0.4f];
}

//下拉刷新闭合
- (void)endRefreshing:(UIRefreshControl *)rc
{
    [rc endRefreshing];//闭合
}

- (void)requestData {
    
    PFUser *currentUser = [PFUser currentUser];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"meUser == %@", currentUser];// 查询focusecond字段为当前用户的所有
    PFQuery *query = [PFQuery queryWithClassName:@"collection" predicate:predicate];
    //    NSLog(@"predicate == %@",predicate);
    //    NSLog(@"query == %@",query);
    
    
    [query includeKey:@"youUser"];//关联查询
    
    [SVProgressHUD show];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *returnedObjects, NSError *error) {
        [SVProgressHUD dismiss];
        
        
//        UIRefreshControl *rc = (UIRefreshControl *)[_Newtable viewWithTag:8001];
//        [rc endRefreshing];
        if (!error) {
            _objectsForShow = returnedObjects;
            NSLog(@"_objectsForShow = %@", _objectsForShow);
            [_Newtable reloadData];
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _objectsForShow.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *TableSampleIdentifier = @"cell";
    
    collectionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                TableSampleIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[collectionViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:TableSampleIdentifier];
    }
    
    
    
    PFObject *object = [_objectsForShow objectAtIndex:indexPath.row];
    PFObject *activity = object[@"youUser"];
    
    
    cell.Newname.text =[NSString stringWithFormat:@"%@", activity[@"businessName"]];
    cell.Newtime.text = [NSString stringWithFormat:@"%@",activity[@"businesshours"]];
    cell.Newaddress.text = [NSString stringWithFormat:@"%@",activity[@"address"]];
    //    NSLog(@"%@",object);
    PFFile *photo = activity[@"businessPhoto"];
    [photo getDataInBackgroundWithBlock:^(NSData *photoData, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:photoData];
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.Newphoto.image = image;
            });
        }
    }];
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PFObject *object = [_objectsForShow objectAtIndex:indexPath.row];
   pageViewController *pvc = [Utilities getStoryboardInstanceByIdentity:@"LDI"];
    //    PFObject *par = object[@"owner"];
    //    pvc.ownername = par;
    pvc.item = object;
    //    pvc.kro =object;
    pvc.hidesBottomBarWhenPushed = YES;//把切换按钮隐藏掉
    [self.navigationController pushViewController:pvc animated:YES];
    
    
}

//UIBarButtonItem *favoBarButton = [[UIBarButtonItem alloc] initWithCustomView:_favoBtn];

//这是在UIBarButtonItem上客制化View的方法

//如果需要在Bar Button Item上设置图片，可以用这个方法把它客制化成一个Button
//self.navigationItem.rightBarButtonItems = @[favoBarButton, shareBarButton];

//这是用代码的方式给导航条右边放置多个Bar Button Item的方法


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
