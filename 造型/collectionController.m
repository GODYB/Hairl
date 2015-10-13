//
//  collectionController.m
//  Hair
//
//  Created by ajw on 15/10/13.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import "collectionController.h"

@interface collectionController ()

@end

@implementation collectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
