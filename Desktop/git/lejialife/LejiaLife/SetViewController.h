//
//  SetViewController.h
//  LejiaLife
//
//  Created by 张强 on 16/4/29.
//  Copyright © 2016年 张强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetViewController : UIViewController
@property(nonatomic,copy)NSString *titleStr;
@property(nonatomic,copy) void(^ExitUpdateBlock)(void);
@end