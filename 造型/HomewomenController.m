//
//  HomewomenController.m
//  Hair
//
//  Created by ajw on 15/9/25.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import "HomewomenController.h"

@interface HomewomenController ()

{
    BOOL _isButtion;
}

- (IBAction)spreads:(UIBarButtonItem *)sender;
- (IBAction)forpoing:(UIBarButtonItem *)sender;

@end

@implementation HomewomenController

- (void)viewDidLoad {
    [super viewDidLoad];
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
@end
