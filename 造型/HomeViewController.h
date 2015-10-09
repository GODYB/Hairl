//
//  HomeViewController.h
//  Hair
//
//  Created by 冰刀画的圈。 on 15/9/23.
//  Copyright (c) 2015年 dzx. All rights reserved.
//
#import<CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface HomeViewController : UIViewController<CLLocationManagerDelegate,UIAlertViewDelegate>
{
    NSInteger count;
    UIImage *_image;
}
@property (strong,nonatomic)CLLocationManager *locationManager;
@property (strong, nonatomic) UILabel *latitudeLable;
@property (strong, nonatomic) UILabel *longitudeLable;
@property(strong,nonatomic)NSArray*objectsForShow;
@property (strong,nonatomic)MKMapView *mapView;

@property (strong, nonatomic) NSString *corse;
@property (weak, nonatomic) IBOutlet UINavigationItem *location;
@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end
