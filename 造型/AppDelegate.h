//
//  AppDelegate.h
//  造型
//
//  Created by 冰刀画的圈。 on 15/9/20.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ECSlidingViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,UIViewControllerAnimatedTransitioning, ECSlidingViewControllerDelegate, ECSlidingViewControllerLayout>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong,nonatomic)ECSlidingViewController *slidingViewController;
@property (assign,nonatomic)ECSlidingViewControllerOperation operation;//当前容器的作

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

