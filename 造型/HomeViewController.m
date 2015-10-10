//
//  HomeViewController.m
//  Hair
//
//  Created by 冰刀画的圈。 on 15/9/23.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import "HomeViewController.h"
#import "ClickViewController.h"
@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate>

{
    BOOL _isButtion;
}
- (IBAction)spreads:(UIBarButtonItem *)sender;
- (IBAction)Trigger:(UIBarButtonItem *)sender;
- (IBAction)xc:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)tangfa:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)ranfa:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)xjc:(UIButton *)sender forEvent:(UIEvent *)event;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _shuzu = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4", nil];
    //[PFUser logOut];
//  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestData) name:@"refreshHome" object:nil];
    [self requestData];
     [NSThread sleepForTimeInterval:1.5];   //设置进程停止2秒
    
//    NSString *path = NSHomeDirectory();//主目录
//    NSLog(@"NSHomeDirectory:%@",path);
//    NSString *userName = NSUserName();//与上面相同
//    NSString *rootPath = NSHomeDirectoryForUser(userName);
//    NSLog(@"NSHomeDirectoryForUser:%@",rootPath);
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory=[paths objectAtIndex:0];//Documents目录
//    NSLog(@"NSDocumentDirectory:%@",documentsDirectory);
    
    
    _tableView.tableFooterView = [[UIView alloc] init];//去掉多余的下划线

    _tableView.hidden =YES;
    /**
     *定位
     */
    _locationManager = [[CLLocationManager alloc]init];
    _locationManager.distanceFilter = kCLDistanceFilterNone;//设置位移
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;//最佳精度
    _locationManager.delegate = self;
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        
#ifdef __IPHONE_8_0
        if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [_locationManager performSelector:@selector(requestWhenInUseAuthorization)];
            
        }
#endif
    }
    [_locationManager startUpdatingLocation];//持续的监控用户位置

    _longitudeLable =  [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width / 2, 50)];
    _longitudeLable.textAlignment = NSTextAlignmentCenter;//文字居中
    [self.view addSubview:_longitudeLable];
    
    _latitudeLable =  [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width / 2, self.view.frame.size.height - 50, self.view.frame.size.width / 2, 50)];
    _latitudeLable .textAlignment = NSTextAlignmentCenter;//文字居中
    [self.view addSubview:_latitudeLable];
    
    
   


}

//添加单利化全局变量 设为0或1的属性
-(void)viewWillAppear:(BOOL)animated
{
   
    
    
    [[storageMgr singletonStorageMgr] removeObjectForKey:@"rukou"];
    [[storageMgr singletonStorageMgr] addKeyAndValue:@"rukou" And:@0]
    ;
    
    [[storageMgr singletonStorageMgr] removeObjectForKey:@"background"];
    [[storageMgr singletonStorageMgr] addKeyAndValue:@"background" And:@0]
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


- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    BOOL shouldUpdate = NO;
    if (count == 0) {
        shouldUpdate = YES;
    } else {
        if (newLocation.coordinate.longitude != oldLocation.coordinate.longitude && newLocation.coordinate.latitude != oldLocation.coordinate.latitude) {
            shouldUpdate = YES;
        }
    }
    count ++;
    if (shouldUpdate) {
        NSLog(@"locationManager 经度 =  %f",newLocation.coordinate.longitude);
        NSLog(@"locationManager 纬度 =  %f",newLocation.coordinate.latitude);
        
    }
//    NSLog(@"%@",newLocation); 经度纬度
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error)
     {
         if (array.count > 0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
             
             //获取城市
             NSString *city = placemark.locality;
             if (!city) {
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 city = placemark.administrativeArea;
             }
              _corse=city;
             self.location.title=city;
             /**
              *UserDfauls 全局变量的定义
              */
             
             //UserDfauls  定义的ID名字  获取你的文件
             [Utilities setUserDefaults:@"City" content:_corse];
         }
         else if (error == nil && [array count] == 0)
         {
             NSLog(@"No results were returned.");
         }
         else if (error != nil)
         {
             NSLog(@"An error occurred = %@", error);
         }
     }];
    
    
    
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC);//线程
    dispatch_after(delayTime, dispatch_get_main_queue(), ^(void){//延迟时间，三个参数分别是：具体延迟时间，线程是什么，在线程里具体做什么事情，过三秒被执行
        [manager stopUpdatingLocation];//关闭定位
    });
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{//没有打开定位时执行的方法
    if (error) {
        [self checkEroor:error];
    }
    
}
-(void)checkEroor:(NSError *)error
{
    switch ([error code]) {
        case kCLErrorNetwork:
            NSLog(@"没有网：%@",[error description]);
            break;
        case kCLErrorDenied:
            NSLog(@"没开定位：%@",[error description]);
            break;
        default:
            NSLog(@"其他：%@",[error description]);
            break;
    }
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
             [_tableView reloadData];
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
- (IBAction)spreads:(UIBarButtonItem *)sender {
     [[NSNotificationCenter defaultCenter] postNotificationName:@"leftSwitch" object:self];//触发通知
}

- (IBAction)Trigger:(UIBarButtonItem *)sender {
    
      //[self requestData];
    
    //设为隐藏
    if(_isButtion == YES){
        _isButtion = NO;
         _tableView.hidden = YES;
     
 
    }else if(_isButtion == NO) {
        _isButtion = YES;
        _tableView.hidden = NO;
    
    }
}

- (IBAction)xc:(UIButton *)sender forEvent:(UIEvent *)event
{
    ClickViewController *receive = [Utilities getStoryboardInstanceByIdentity:@"IdClick"];
    receive.nameitem = _shuzu[0];
    NSLog(@"%@",_shuzu[0]);
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

- (IBAction)ranfa:(UIButton *)sender forEvent:(UIEvent *)event
{
    ClickViewController *receive = [Utilities getStoryboardInstanceByIdentity:@"IdClick"];
    receive.nameitem = _shuzu[2];
    NSLog(@"%@",_shuzu[2]);
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



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PFObject *object = [_objectsForShow objectAtIndex:[indexPath row]]; //这个表示选中的那个cell上的数据
    NSString *hh = [NSString stringWithFormat:@"%@", object[@"cityName"]];
    _location.title=hh;
    
    if(_isButtion == YES){
        _isButtion = NO;
        _tableView.hidden = YES;
        
        
    }else if(_isButtion == NO) {
        _isButtion = YES;
        _tableView.hidden = NO;
        
    }

}

//创建一个user defaults方法有多个，最简单得快速创建方法:
//NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
//
//添加数据到 user defaults:
//[accountDefaults setObject:nameField.text forKey:UserDefaultNameKey];
//也可以添加基本数据类型int, float, bool等，有相应得方法
//
//[accountDefaults setBool:YES forKey:UserDefaultBoolKey];
//
//从user defaults中获取数据:
//
//[accountDefaults objectForKey:NCUserDefaultNameKey]
//
//
//[accountDefaults boolForKey: UserDefaultBoolKey];



/**
 *文本输入框的判断
 */
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    if (textField == _username) {
//        if (![string isEqualToString:@""]) {
//            _unInput = [NSString stringWithFormat:@"%@%@", _unInput, string];
//            // NSLog(@"%@", _unInput);
//        } else {
//            _unInput = [_unInput substringToIndex:(_unInput.length - 1)];
//            // NSLog(@"%@", _unInput);
//        }
//        [self setHeaderImage];
//    }
//    return YES;
//}
//
//- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    if (textField == _username) {
//        _unInput = _username.text;
//    }
//}

@end
