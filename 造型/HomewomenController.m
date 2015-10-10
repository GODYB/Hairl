//
//  HomewomenController.m
//  Hair
//
//  Created by ajw on 15/9/25.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import "HomewomenController.h"
#import "ClickViewController.h"
@interface HomewomenController ()

{
    BOOL _isButtion;
}

- (IBAction)spreads:(UIBarButtonItem *)sender;
- (IBAction)forpoing:(UIBarButtonItem *)sender;
- (IBAction)ranfa:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)tangfa:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)xc:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)xjc:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)huli:(UIButton *)sender forEvent:(UIEvent *)event;

@end

@implementation HomewomenController

- (void)viewDidLoad {
    [super viewDidLoad];
    _shuzu = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4", @"5",nil];
    // Do any additional setup after loading the view.
    /**
     *UserDfauls 的接受
     */
    NSString *city = [Utilities getUserDefaults:@"City"];
    NSLog(@"%@", city);
    
    self.location.title=city;
    
    _positioning.tableFooterView = [[UIView alloc] init];//去掉多余的下划线
    _positioning.separatorStyle = UITableViewCellSeparatorStyleNone;
    _positioning.hidden =YES;
    
    [self requestData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [[storageMgr singletonStorageMgr] removeObjectForKey:@"rukou"];
    [[storageMgr singletonStorageMgr] addKeyAndValue:@"rukou" And:@1];
    
    [[storageMgr singletonStorageMgr] removeObjectForKey:@"background"];
    [[storageMgr singletonStorageMgr] addKeyAndValue:@"background" And:@1]
    ;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enablePanGes" object:self];//激活滑动手势
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disablePanGes" object:self];//关闭滑动手势
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
-(void)requestData {
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"city"];
    
    [query selectKeys:@[@"cityName"]];
    
    //    NSLog(@"%@",query);
    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray *returnedObjects, NSError *error)
     {
         [aiv stopAnimating];
         if (!error)
         {
             _objectsForShow = returnedObjects;
             NSLog(@"_objectsForShow = %@", _objectsForShow);
             [_positioning reloadData];
         }
         else
         {
             NSLog(@"Error: %@ %@", error, [error userInfo]);
         }
     }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _objectsForShow.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFObject *object = [_objectsForShow objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", object[@"cityName"]];
  
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PFObject *object = [_objectsForShow objectAtIndex:[indexPath row]]; //这个表示选中的那个cell上的数据
    NSString *hh = [NSString stringWithFormat:@"%@", object[@"cityName"]];
    _location.title=hh;
    
    if(_isButtion == YES){
        _isButtion = NO;
        _positioning.hidden = YES;
        
        
    }else if(_isButtion == NO) {
        _isButtion = YES;
        _positioning.hidden = NO;
        
    }
    
}
- (IBAction)spreads:(UIBarButtonItem *)sender {
     [[NSNotificationCenter defaultCenter] postNotificationName:@"leftSwitch" object:self];//触发通知
}

- (IBAction)forpoing:(UIBarButtonItem *)sender {
    
    //设为隐藏
    if(_isButtion == YES){
        _isButtion = NO;
        _positioning.hidden = YES;
        
        
    }else if(_isButtion == NO) {
        _isButtion = YES;
        _positioning.hidden = NO;
        
    }
}

- (IBAction)ranfa:(UIButton *)sender forEvent:(UIEvent *)event
{
    ClickViewController *receive = [Utilities getStoryboardInstanceByIdentity:@"IdClick"];
    receive.nameitem = _shuzu[2];
    NSLog(@"%@",_shuzu[2]);
    receive.hidesBottomBarWhenPushed = YES;//隐藏切换按钮
    [self.navigationController pushViewController:receive animated:YES];
}

- (IBAction)tangfa:(UIButton *)sender forEvent:(UIEvent *)event
{
    ClickViewController *receive = [Utilities getStoryboardInstanceByIdentity:@"IdClick"];
    receive.nameitem = _shuzu[1];
    NSLog(@"%@",_shuzu[1]);
    receive.hidesBottomBarWhenPushed = YES;//隐藏切换按钮
    [self.navigationController pushViewController:receive animated:YES];
}

- (IBAction)xc:(UIButton *)sender forEvent:(UIEvent *)event
{
    ClickViewController *receive = [Utilities getStoryboardInstanceByIdentity:@"IdClick"];
    receive.nameitem = _shuzu[0];
    NSLog(@"%@",_shuzu[0]);
    receive.hidesBottomBarWhenPushed = YES;//隐藏切换按钮
    [self.navigationController pushViewController:receive animated:YES];
}

- (IBAction)xjc:(UIButton *)sender forEvent:(UIEvent *)event
{
    ClickViewController *receive = [Utilities getStoryboardInstanceByIdentity:@"IdClick"];
    receive.nameitem = _shuzu[3];
    NSLog(@"%@",_shuzu[3]);
    receive.hidesBottomBarWhenPushed = YES;//隐藏切换按钮
    [self.navigationController pushViewController:receive animated:YES];
}

- (IBAction)huli:(UIButton *)sender forEvent:(UIEvent *)event
{
    ClickViewController *receive = [Utilities getStoryboardInstanceByIdentity:@"IdClick"];
    receive.nameitem = _shuzu[4];
    NSLog(@"%@",_shuzu[4]);
    receive.hidesBottomBarWhenPushed = YES;//隐藏切换按钮
    [self.navigationController pushViewController:receive animated:YES];
}
@end
