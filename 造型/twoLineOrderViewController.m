//
//  twoLineOrderViewController.m
//  Hair
//
//  Created by 冰刀画的圈。 on 15/10/10.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import "twoLineOrderViewController.h"

@interface twoLineOrderViewController ()

@end

@implementation twoLineOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     PFFile *photo = _orderitem[@"uploadPictures"];
    [photo getDataInBackgroundWithBlock:^(NSData *photoData, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:photoData];
            dispatch_async(dispatch_get_main_queue(), ^{
                _image.image = image;
            });
        }
    }];
    _ordername.text = [NSString stringWithFormat:@"%@",_orderitem[@"orderName"]];
    _orderprice.text = [NSString stringWithFormat:@"%@",_orderitem[@"orderPrice"]];
    _shuming.text = [NSString stringWithFormat:@"%@",_orderitem[@"orderState"]];
    _ordertext.text = [NSString stringWithFormat:@"%@",_orderitem[@"orderText"]];

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

@end
