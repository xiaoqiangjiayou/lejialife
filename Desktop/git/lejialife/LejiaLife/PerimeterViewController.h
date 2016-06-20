//
//  PerimeterViewController.h
//  LejiaLife
//
//  Created by 张强 on 16/3/21.
//  Copyright © 2016年 张强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface PerimeterViewController : BaseViewController
//初始化单例
+ (PerimeterViewController *)sharedInstance;

//初始化百度地图用户位置管理类
- (void)initBMKUserLocation;

//开始定位
-(void)startLocation;

//停止定位
-(void)stopLocation;
@end
