//
//  AppDelegate.h
//  LejiaLife
//
//  Created by 张强 on 16/3/21.
//  Copyright © 2016年 张强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlideViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic)LeftSlideViewController *leftSlide;
@property(nonatomic,strong)UITabBarController *tabbarcontrol;
@property(nonatomic)UINavigationController *nav;
@property(nonatomic)BMKMapManager * mapManager;
- (void)creatRootVC;
@end

