//
//  lineOrderViewController.m
//  Hair
//
//  Created by 冰刀画的圈。 on 15/10/10.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import "lineOrderViewController.h"
#import "lineOrderTableViewCell.h"
#import "twoLineOrderViewController.h"
@interface lineOrderViewController ()

@end

@implementation lineOrderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableview.tableFooterView = [[UIView alloc] init];//去掉tableView多余的横线
    //到Parserq去读取数据
    [self requestData];
    [self uiConfiguration];
    
     self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"X-bj"]];
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
    [_tableview addSubview:refreshControl];
}
- (void)refreshData:(UIRefreshControl *)rc
{
    [self requestData];
    [_tableview reloadData];
    
    //怎么样让方法延迟执行的
    [self performSelector:@selector(endRefreshing:) withObject:rc afterDelay:1.f];
}
//下拉刷新闭合
- (void)endRefreshing:(UIRefreshControl *)rc
{
    [rc endRefreshing];//闭合
}
- (void)requestData
{
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
    PFQuery *query = [PFQuery queryWithClassName:@"Order"];//查询的是那张表
//    [query selectKeys:@[@"orderPrice",@"orderState",@"orderName",@"uploadPictures"]];//查询条件，自己数据库里的城市后面的是城市名
    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray *returnedObjects, NSError *error) {
        [aiv stopAnimating];
        if (!error) {
            _objectsForShow = returnedObjects;
            NSLog(@"%@", _objectsForShow);
            [_tableview reloadData];
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
  }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _objectsForShow.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"Cell";
    
    lineOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                TableSampleIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[lineOrderTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:TableSampleIdentifier];
    }
    PFObject *object = [_objectsForShow objectAtIndex:indexPath.row];
    
    [object[@"uploadPictures"] getDataInBackgroundWithBlock:^(NSData *photoData, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:photoData];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (image) {
                    cell.image.image = image;
                } else {
                    NSLog(@"IN");
                    cell.image.image = nil;
                }
            });
        }
    }];
    
    
    
    cell.ordername.text = [NSString stringWithFormat:@"%@",object[@"orderName"]];
    cell.orderpeice.text = [NSString stringWithFormat:@"%@",object[@"orderPrice"]];
    cell.zhutai.text = [NSString stringWithFormat:@"%@",object[@"orderState"]];
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"Item"])
    {
        //把本页的数据传给下一页
        PFObject *object = [_objectsForShow objectAtIndex:[_tableview indexPathForSelectedRow].row];//获取tableView 选中当前行的数据
        twoLineOrderViewController *miVC = segue.destinationViewController;//去到那个控制器
        miVC.orderitem = object;
        miVC.hidesBottomBarWhenPushed = YES;//隐藏切换按钮

    }
}


@end
